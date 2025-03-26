import { fileURLToPath } from 'url';
import { join } from 'path';
import fs from 'fs';
import { checkLinksInHtml , normalizeHtmlFilePath } from './check-links.js';
import fastGlob from 'fast-glob';

export default function astroBrokenLinksChecker(options = {}) {
  const logFilePath = options.logFilePath || 'broken-links.log';
  const brokenLinksMap = new Map(); // Map of brokenLink -> Set of documents
  const checkedLinks = new Map();

  return {
    
    name: 'astro-broken-links-checker',
    hooks: {
      'astro:config:setup': async ({ config }) => {
        //console.log('config.redirects', config.redirects);
        // save the redirects to the options
        options.astroConfigRedirects = config.redirects;
      },
      
      'astro:build:done': async ({ dir, logger }) => {

        const astroConfigRedirects = options.astroConfigRedirects;
        //console.log('astroConfigRedirects', astroConfigRedirects);
        const distPath = fileURLToPath(dir);
        const htmlFiles = await fastGlob('**/*.html', { cwd: distPath });
        logger.info(`Checking ${htmlFiles.length} html pages for broken links`);
        // start time
        const startTime = Date.now();
        const checkHtmlPromises = htmlFiles.map(async (htmlFile) => {
          const absoluteHtmlFilePath = join(distPath, htmlFile);
          const htmlContent = fs.readFileSync(absoluteHtmlFilePath, 'utf8');
          const baseUrl = normalizeHtmlFilePath(absoluteHtmlFilePath, distPath);
          await checkLinksInHtml(
            htmlContent,
            brokenLinksMap,
            baseUrl,
            absoluteHtmlFilePath, // Document path
            checkedLinks,
            distPath,
            astroConfigRedirects,
            logger,
            options.checkExternalLinks
          );
        });
        await Promise.all(checkHtmlPromises);
        logBrokenLinks(brokenLinksMap, logFilePath, logger);
        // end time
        const endTime = Date.now();
        logger.info(`Time to check links: ${endTime - startTime} ms`);
      },
    },
  };
}

function logBrokenLinks(brokenLinksMap, logFilePath, logger) {
  if (brokenLinksMap.size > 0) {
    let logData = '';
    for (const [brokenLink, documentsSet] of brokenLinksMap.entries()) {
      const documents = Array.from(documentsSet);
      logData += `Broken link: ${brokenLink}\n  Found in:\n`;
      for (const doc of documents) {
        logData += `    - ${doc}\n`;
      }
    }
    logData = logData.trim();
    if (logFilePath) {
      fs.writeFileSync(logFilePath, logData, 'utf8');
      logger.info(`Broken links have been logged to ${logFilePath}`);
      logger.info(logData);
    } else {
      logger.info(logData);
    }
  } else {
    logger.info('No broken links detected.');
  }
}