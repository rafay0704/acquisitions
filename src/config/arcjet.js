import arcjet, { shield, detectBot, slidingWindow } from '@arcjet/node';

const aj = arcjet({
  // Get your site key from https://app.arcjet.com and set it as an environment variable
  key: process.env.ARCJET_KEY,
  rules: [
    // Shield protects your app from common attacks
    shield({ mode: 'LIVE' }),

    // Bot detection rule
    detectBot({
      mode: 'LIVE', // Blocks requests. Use "DRY_RUN" to log only
      allow: [
        'CATEGORY:SEARCH_ENGINE', // Google, Bing, etc
        'CATEGORY:PREVIEW', // Link previews e.g. Slack, Discord
      ],
    }),

    // Rate limiting rule
    slidingWindow({
      mode: 'LIVE',
      interval: '2s', // every 2 seconds
      max: 5, // max 5 requests per interval
    }),
  ],
});

export default aj;
