/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        hostname: 'www.google.com',
      },
      {
        hostname: 'img.mytsi.org',
      },
      {
        hostname: 'www.google-analytics.com',
      }
    ],
  },
};

export default nextConfig;
