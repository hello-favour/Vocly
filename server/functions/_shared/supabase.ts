import { createClient } from "https://esm.sh/@supabase/supabase-js@2.49.1";
import { HttpError } from "./http.ts";

export type SupabaseClient = ReturnType<typeof createClient>;

export function createAdminClient(): SupabaseClient {
  const url = Deno.env.get("SUPABASE_URL");
  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

  if (!url || !serviceRoleKey) {
    throw new Error("Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY");
  }

  return createClient(url, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });
}

export async function requireUserId(req: Request, supabase: SupabaseClient): Promise<string> {
  const authHeader = req.headers.get("Authorization");
  const token = authHeader?.replace(/^Bearer\s+/i, "");

  if (!token) {
    throw new HttpError("Missing bearer token", 401);
  }

  const { data, error } = await supabase.auth.getUser(token);
  if (error || !data.user) {
    throw new HttpError("Invalid bearer token", 401, error);
  }

  return data.user.id;
}

export async function updateStreak(supabase: SupabaseClient, userId: string): Promise<void> {
  const { error } = await supabase.rpc("update_streak", { p_user_id: userId });
  if (error) throw error;
}
