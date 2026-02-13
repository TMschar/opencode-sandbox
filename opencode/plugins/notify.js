export const NotificationPlugin = async ({ client, $ }) => {
  const apprise_url = process.env.APPRISE_URL;
  if (!apprise_url) {
    await client.app.log({ severity: "error", message: "APPRISE_URL is not set. Notifications disabled." });
    return {};
  }

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`apprise -b "Opencode session completed" "${apprise_url}"`;
      }
    }
  };
};