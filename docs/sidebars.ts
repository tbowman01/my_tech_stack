import type {SidebarsConfig} from '@docusaurus/plugin-content-docs';

const sidebars: SidebarsConfig = {
  tutorialSidebar: [
    'intro',
    {
      type: 'category',
      label: '🎮 Adventure Quests',
      collapsed: false,
      items: [
        'quests/getting-started',
        'quests/security-champion', 
        'quests/ai-explorer',
        'quests/devops-master',
      ],
    },
    {
      type: 'category',
      label: '🚀 Getting Started',
      items: [
        'getting-started/prerequisites',
        'getting-started/local-development',
        'getting-started/first-deployment',
      ],
    },
    {
      type: 'category',
      label: 'Architecture',
      items: [
        'architecture/overview',
        'architecture/services',
        'architecture/security',
        'architecture/data-flow',
        'architecture/observability',
      ],
    },
    {
      type: 'category',
      label: 'Development',
      items: [
        'development/workflow',
        'development/testing',
        'development/debugging',
        'development/conventions',
      ],
    },
    {
      type: 'category',
      label: 'Deployment',
      items: [
        'deployment/environments',
        'deployment/ci-cd',
        'deployment/monitoring',
        'deployment/scaling',
      ],
    },
    {
      type: 'category',
      label: 'API Reference',
      items: [
        'api/rest-api',
        'api/grpc-api',
        'api/authentication',
        'api/rate-limiting',
      ],
    },
    {
      type: 'category',
      label: 'Runbooks',
      items: [
        'runbooks/overview',
        'runbooks/incident-response',
        'runbooks/disaster-recovery',
        'runbooks/maintenance',
      ],
    },
    'contributing',
  ],
};

export default sidebars;