import type { LinksData } from '../types/links';

export const streamingLinks: LinksData = {
  docs_list_title: "Streaming",
  docs: [
    
    {
      title: "Music Platforms",
      isExpandable: true,
      colour: "bg-cyan-600",
      icon: "lucide:music",
      children: [
        {
          title: "Buy on Bandcamp",
          url: "https://olifrost.bandcamp.com",
          colour: "bg-cyan-600",
          icon: "lucide:music"
        },
        {
          title: "Apple Music",
          url: "https://music.apple.com/gb/artist/oli-frost/1476842962",
          colour: "bg-red-500",
          icon: "lucide:music"
        },
        {
          title: "Spotify",
          url: "https://open.spotify.com/artist/5dFJdXPDdubN7e6RIC2MXP",
          colour: "bg-green-600",
          icon: "lucide:music"
        },
        {
          title: "Deezer",
          url: "https://www.deezer.com/en/artist/8466006",
          colour: "bg-purple-600",
          icon: "lucide:music"
        }
      ]
    },
    {
      title: "YouTube",
      url: "https://www.youtube.com/channel/UC11YzVs4e4h9kIt4VzUS6yQ",
      colour: "bg-red-600",
      icon: "lucide:video"
    }
  ]
};

export const links: LinksData = {
  docs_list_title: "Links",
  docs: [
    {
      title: "Website & bio",
      url: "/",
      colour: "bg-blue-600",
      icon: "lucide:globe"
    },
    {
      title: "Stream my music",
      isExpandable: true,
      colour: "bg-green-600",
      icon: "lucide:heart",
      children: [
        {
          title: "Buy on Bandcamp",
          url: "https://olifrost.bandcamp.com",
          colour: "bg-cyan-600",
          icon: "lucide:music"
        },
        {
          title: "Apple Music",
          url: "https://music.apple.com/gb/artist/oli-frost/1476842962",
          colour: "bg-red-500",
          icon: "lucide:music"
        },
        {
          title: "Spotify",
          url: "https://open.spotify.com/artist/5dFJdXPDdubN7e6RIC2MXP",
          colour: "bg-green-600",
          icon: "lucide:music"
        },
        {
          title: "Deezer",
          url: "https://www.deezer.com/en/artist/8466006",
          colour: "bg-purple-600",
          icon: "lucide:music"
        }
        
      ]
    },
    {
      title: "Support my work",
      isExpandable: true,
      colour: "bg-red-600",
      icon: "lucide:heart",
      children: [
        {
          title: "Join my patreon",
          url: "https://www.patreon.com/olifrost",
          colour: "bg-stone-950",
          icon: "lucide:heart"
        },
        {
          title: "Send a tip on Ko-Fi",
          url: "https://ko-fi.com/olifrost",
          colour: "bg-orange-500",
          icon: "lucide:coffee"
        }        
      ]
    },
    {
      title: "Play Asset Manager Quest",
      url: "https://assetmanager.quest",
      colour: "bg-pink-500",
      icon: "lucide:gamepad-2"
    },
    {
      title: "Join Discord",
      url: "https://discord.gg/VxF3JDR5Ux",
      colour: "bg-indigo-600",
      icon: "lucide:messages-square"
    },
    {
      title: "Book me for a gig, etc",
      url: "mailto:mail@olifro.st",
      colour: "bg-blue-800",
      icon: "lucide:mail"
    }
  ]
};