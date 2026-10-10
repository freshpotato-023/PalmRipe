# PalmRipe

A mobile-first oil palm fruit ripeness screening app based on the Chapter I study. The interface supports phone camera capture, image upload, Otsu foreground segmentation, optional CNN inference, on-device scan history, and private Supabase history for signed-in users.

## Start locally

1. Install Node.js 20.19+ or 22.12+.
2. Run `npm install` and `npm run dev`.
3. Open the local URL from Vite. Use HTTPS or localhost for camera capture.

## Supabase setup

1. Create a Supabase project and copy `.env.example` to `.env.local`.
2. Set `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` using the project URL and publishable/anon key.
3. Run `supabase/schema.sql` in the Supabase SQL editor.
4. Enable Email OTP in Supabase Auth and set the site's URL and redirect URLs to your app URL.
5. Restart Vite. Scan records are stored locally by default; after email-link sign-in, new records sync to the signed-in account.

## CNN inference integration

The chapter does not include a trained CNN, labeled image dataset, or model metrics. The built-in Otsu and color-screening result is therefore marked as a prototype estimate, not a validated CNN prediction. To connect a trained model, set `VITE_CLASSIFIER_API_URL` to an HTTPS endpoint accepting multipart form data with an `image` field. Return JSON such as:

```json
{"stage":"ripe","confidence":0.91}
```

`stage` must be `unripe`, `underripe`, or `ripe`; confidence may be 0–1 or 0–100. The service should apply the study's Otsu preprocessing and CNN and must be deployed separately.
