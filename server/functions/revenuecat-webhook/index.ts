import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { error, errorFromUnknown, json } from "../_shared/http.ts";
import { createAdminClient } from "../_shared/supabase.ts";

type RevenueCatEvent = {
  event?: {
    type?: string;
    app_user_id?: string;
    entitlement_ids?: string[];
  };
};

const activeEventTypes = new Set([
  "INITIAL_PURCHASE",
  "RENEWAL",
  "UNCANCELLATION",
  "NON_RENEWING_PURCHASE",
  "PRODUCT_CHANGE",
]);

serve(async (req) => {
  if (req.method !== "POST") return error("Method not allowed", 405);

  const expectedSecret = Deno.env.get("REVENUECAT_WEBHOOK_SECRET");
  const authorization = req.headers.get("Authorization");
  if (!expectedSecret || authorization !== `Bearer ${expectedSecret}`) {
    return error("Unauthorized", 401);
  }

  try {
    const payload = await req.json() as RevenueCatEvent;
    const event = payload.event;
    const userId = event?.app_user_id;
    const eventType = event?.type;

    if (!userId || !eventType) return error("Invalid webhook payload", 400);

    const hasProEntitlement = event?.entitlement_ids?.includes("pro") ?? false;
    const shouldEnable = activeEventTypes.has(eventType) && hasProEntitlement;
    const shouldDisable = eventType == "EXPIRATION";

    if (!shouldEnable && !shouldDisable) {
      return json({ ok: true, ignored: eventType });
    }

    const supabase = createAdminClient();
    const { error: updateError } = await supabase
      .from("profiles")
      .update({
        is_pro: shouldEnable,
        updated_at: new Date().toISOString(),
      })
      .eq("id", userId);

    if (updateError) throw updateError;
    return json({ ok: true, is_pro: shouldEnable });
  } catch (cause) {
    return errorFromUnknown(cause, "RevenueCat webhook failed");
  }
});
