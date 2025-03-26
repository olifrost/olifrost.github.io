export interface Link {
  title: string;
  url?: string;
  colour: string;  // Now expects Tailwind classes like "bg-blue-600"
  icon: string;    // Now expects lucide icon names like "lucide:music"
  isExpandable?: boolean;
  children?: Link[];
}

export interface LinksData {
  docs_list_title: string;
  docs: Link[];
}