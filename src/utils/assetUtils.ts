import type { ImageMetadata } from 'astro';

/**
 * Resolves an @assets/ path to an ImageMetadata object
 * @param assetPath Path in format '@assets/path/to/image.jpg'
 * @returns The ImageMetadata object or undefined if not found
 */
export function resolveAssetPath(assetPath: string): ImageMetadata | undefined {
  if (!assetPath.startsWith('@assets/')) {
    return undefined;
  }
  
  const normalizedPath = assetPath.replace('@assets/', 'src/assets/');
  
  // Use import.meta.glob to find the matching image
  const images = import.meta.glob<{ default: ImageMetadata }>('/src/assets/**/*.{jpg,jpeg,png,gif,webp}', { eager: true });
  
  // Find the image that matches the path
  const matchingImage = Object.entries(images).find(([path]) => 
    path.endsWith(normalizedPath.substring(normalizedPath.indexOf('src/assets/') + 'src/assets/'.length))
  );
  
  return matchingImage ? matchingImage[1].default : undefined;
}

/**
 * Check if a value is an @assets path string
 */
export function isAssetPath(value: unknown): value is `@assets/${string}` {
  return typeof value === 'string' && value.startsWith('@assets/');
}

/**
 * All image file extensions supported by the asset system
 */
export const SUPPORTED_IMAGE_FORMATS = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.avif', '.svg'];