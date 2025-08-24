import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: '🎮 Enterprise AI Platform',
  tagline: 'Your gamified journey to platform mastery - Earn XP, unlock achievements, become an expert!',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://enterprise-ai-platform.example.com',
  // Set the /<baseUrl>/ pathname under which your site is served
  baseUrl: '/',

  // GitHub pages deployment config
  organizationName: 'your-org',
  projectName: 'enterprise-ai-platform',

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Custom fields for gamification
  customFields: {
    gamification: {
      enabled: true,
      trackingEnabled: true,
      achievements: true,
      leaderboard: true
    },
    questSystem: {
      totalQuests: 4,
      totalAchievements: 42,
      maxXP: 2500
    }
  },

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          editUrl: 'https://github.com/your-org/enterprise-ai-platform/tree/main/docs/',
        },
        blog: {
          showReadingTime: true,
          editUrl: 'https://github.com/your-org/enterprise-ai-platform/tree/main/docs/',
        },
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    image: 'img/docusaurus-social-card.jpg',
    // Gamification color scheme
    colorMode: {
      defaultMode: 'light',
      disableSwitch: false,
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: '🎮 Enterprise AI Platform',
      logo: {
        alt: 'Enterprise AI Platform - Gamified Learning',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'tutorialSidebar',
          position: 'left',
          label: '📚 Quests & Guides',
        },
        {
          to: '/docs/quests/getting-started',
          label: '🚀 Start Quest',
          position: 'left',
        },
        {
          type: 'dropdown',
          label: '🏆 Achievements',
          position: 'left',
          items: [
            {
              to: '/docs/quests/getting-started',
              label: '📚 Tutorial Quest (150 XP)',
            },
            {
              to: '/docs/quests/security-champion',
              label: '🛡️ Security Champion (300 XP)',
            },
            {
              to: '/docs/quests/ai-explorer',
              label: '🤖 AI Explorer (450 XP)',
            },
            {
              to: '/docs/quests/devops-master',
              label: '⚙️ DevOps Master (500 XP)',
            },
          ],
        },
        {to: '/blog', label: '📝 Adventure Log', position: 'left'},
        {
          type: 'dropdown',
          label: '🎯 Progress',
          position: 'right',
          items: [
            {
              label: '📊 My Stats',
              href: '#',
            },
            {
              label: '🏅 Leaderboard', 
              href: '#',
            },
            {
              label: '🎮 All Achievements',
              href: '#',
            },
          ],
        },
        {
          href: 'https://github.com/your-org/enterprise-ai-platform',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: '🎮 Adventure Paths',
          items: [
            {
              label: '🚀 Start Your Journey',
              to: '/docs/intro',
            },
            {
              label: '📚 Tutorial Quest',
              to: '/docs/quests/getting-started',
            },
            {
              label: '🛡️ Security Champion',
              to: '/docs/quests/security-champion',
            },
            {
              label: '🤖 AI Explorer',
              to: '/docs/quests/ai-explorer',
            },
            {
              label: '⚙️ DevOps Master',
              to: '/docs/quests/devops-master',
            },
          ],
        },
        {
          title: '📚 Knowledge Base',
          items: [
            {
              label: '🏗️ Architecture',
              to: '/docs/architecture',
            },
            {
              label: '📡 API Reference',
              to: '/docs/api',
            },
            {
              label: '🔒 Security Model',
              to: '/docs/security',
            },
            {
              label: '📖 Runbooks',
              to: '/docs/runbooks/overview',
            },
          ],
        },
        {
          title: '🌟 Community',
          items: [
            {
              label: '💬 Discord Adventures',
              href: 'https://discordapp.com/invite/enterprise-ai-platform',
            },
            {
              label: '🏆 Achievement Leaderboard',
              href: '#leaderboard',
            },
            {
              label: '📊 Stack Overflow',
              href: 'https://stackoverflow.com/questions/tagged/enterprise-ai-platform',
            },
            {
              label: '🐦 Twitter Updates',
              href: 'https://twitter.com/enterprise_ai_platform',
            },
          ],
        },
        {
          title: '🚀 Resources',
          items: [
            {
              label: '📝 Adventure Log (Blog)',
              to: '/blog',
            },
            {
              label: '🔧 GitHub Repository',
              href: 'https://github.com/your-org/enterprise-ai-platform',
            },
            {
              label: '🎯 Contribute & Earn XP',
              to: '/docs/contributing',
            },
            {
              label: '📈 Platform Status',
              href: 'https://status.enterprise-ai-platform.com',
            },
          ],
        },
      ],
      copyright: `🎮 Copyright © ${new Date().getFullYear()} Your Organization. Built with ❤️ and gamification magic! | 🏆 Total Community XP: 1,247,328`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['rust', 'toml', 'yaml', 'docker', 'bash'],
    },
    mermaid: {
      theme: {light: 'neutral', dark: 'dark'},
    },
  } satisfies Preset.ThemeConfig,

  themes: ['@docusaurus/theme-mermaid'],

  markdown: {
    mermaid: true,
  },
};

export default config;