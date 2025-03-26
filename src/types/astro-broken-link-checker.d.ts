declare module 'astro-broken-link-checker' {
  interface AstroBrokenLinkCheckerOptions {
    logFilePath?: string;
    checkExternalLinks?: boolean;
  }
  
  export default function astroBrokenLinksChecker(
    options?: AstroBrokenLinkCheckerOptions
  ): any;
}