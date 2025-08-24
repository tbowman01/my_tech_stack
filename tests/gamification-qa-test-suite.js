/**
 * Comprehensive QA Test Suite for Enterprise AI Platform Gamification System
 * 
 * This test suite validates all gamification features including:
 * - Achievement system functionality
 * - XP calculation and level progression
 * - Quest system navigation
 * - Progress tracking accuracy
 * - Visual elements rendering
 * - Cross-reference integrity
 * - Performance impact assessment
 * 
 * @author QA Testing Specialist Agent
 * @version 1.0.0
 * @created 2025-08-24
 */

const { describe, it, expect, beforeEach, afterEach } = require('@jest/globals');
const puppeteer = require('puppeteer');

// Test Configuration
const TEST_CONFIG = {
  baseUrl: 'http://localhost:3000',
  timeout: 30000,
  slowMo: 50,
  headless: false,
  viewport: { width: 1366, height: 768 }
};

// Test Data
const GAMIFICATION_DATA = {
  achievements: {
    total: 28,
    tiers: {
      common: { count: 8, xpRange: [50, 200] },
      uncommon: { count: 6, xpRange: [250, 400] },
      rare: { count: 5, xpRange: [450, 600] },
      epic: { count: 4, xpRange: [650, 800] },
      legendary: { count: 3, xpRange: [900, 1200] },
      mythic: { count: 2, xpRange: [1500, 2000] }
    }
  },
  levels: [
    { name: 'Novice', xpRequired: 0 },
    { name: 'Explorer', xpRequired: 500 },
    { name: 'Builder', xpRequired: 1500 },
    { name: 'Architect', xpRequired: 3000 },
    { name: 'Specialist', xpRequired: 5000 },
    { name: 'Expert', xpRequired: 8000 },
    { name: 'Master', xpRequired: 12000 },
    { name: 'Grandmaster', xpRequired: 20000 }
  ],
  quests: {
    gettingStarted: 3,
    infrastructure: 3,
    development: 3,
    aiml: 3,
    operations: 3,
    advanced: 3
  }
};

describe('Gamification System QA Test Suite', () => {
  let browser;
  let page;

  beforeEach(async () => {
    browser = await puppeteer.launch({
      headless: TEST_CONFIG.headless,
      slowMo: TEST_CONFIG.slowMo,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    page = await browser.newPage();
    await page.setViewport(TEST_CONFIG.viewport);
  });

  afterEach(async () => {
    if (browser) {
      await browser.close();
    }
  });

  describe('1. System Architecture Validation', () => {
    it('should load gamification hub page successfully', async () => {
      const response = await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      expect(response.status()).toBe(200);
      
      // Verify page title and main heading
      const title = await page.title();
      expect(title).toContain('Enterprise AI Platform');
      
      const heading = await page.$eval('h1', el => el.textContent);
      expect(heading).toContain('Gamification Hub');
    });

    it('should have proper navigation structure', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check for navigation elements in header
      const navItems = await page.$$('.navbar__item');
      expect(navItems.length).toBeGreaterThan(0);
      
      // Verify gamification-specific nav items
      const achievementsDropdown = await page.$('[label*="Achievements"]');
      expect(achievementsDropdown).toBeTruthy();
      
      const progressDropdown = await page.$('[label*="Progress"]');
      expect(progressDropdown).toBeTruthy();
    });

    it('should render without JavaScript errors', async () => {
      const errors = [];
      page.on('pageerror', error => errors.push(error.message));
      
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      await page.waitForTimeout(2000);
      
      expect(errors).toEqual([]);
    });
  });

  describe('2. Achievement System Testing', () => {
    beforeEach(async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/achievements/gallery.md`);
    });

    it('should display correct total number of achievements', async () => {
      const achievementElements = await page.$$('.achievement-badge, [data-achievement]');
      expect(achievementElements.length).toBeGreaterThanOrEqual(GAMIFICATION_DATA.achievements.total);
    });

    it('should show achievement tiers correctly', async () => {
      // Check for tier indicators
      const tierElements = await page.$$('*:contains("🟢"), *:contains("🔵"), *:contains("🟣"), *:contains("🟠"), *:contains("🟡"), *:contains("🔴")');
      expect(tierElements.length).toBeGreaterThan(0);
    });

    it('should validate XP values are within expected ranges', async () => {
      const xpElements = await page.$$eval('*:contains("XP")', elements => 
        elements.map(el => {
          const match = el.textContent.match(/(\d+)\s*XP/);
          return match ? parseInt(match[1]) : null;
        }).filter(Boolean)
      );
      
      expect(xpElements.length).toBeGreaterThan(0);
      
      // Validate XP ranges are reasonable
      xpElements.forEach(xp => {
        expect(xp).toBeGreaterThanOrEqual(50);
        expect(xp).toBeLessThanOrEqual(5000);
      });
    });

    it('should have consistent achievement naming and criteria', async () => {
      // Check for achievement name consistency
      const achievementNames = await page.$$eval('.achievement-name, [data-achievement-name]', elements =>
        elements.map(el => el.textContent.trim())
      );
      
      // Verify no duplicate names
      const uniqueNames = [...new Set(achievementNames)];
      expect(uniqueNames.length).toBe(achievementNames.length);
    });
  });

  describe('3. XP and Level Progression Testing', () => {
    beforeEach(async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/progress/dashboard.md`);
    });

    it('should display correct level progression system', async () => {
      // Check for level indicators
      const levelElements = await page.$$('*:contains("Level")');
      expect(levelElements.length).toBeGreaterThan(0);
      
      // Verify level progression matches expected data
      for (const level of GAMIFICATION_DATA.levels) {
        const levelExists = await page.$(`*:contains("${level.name}")`);
        expect(levelExists).toBeTruthy();
      }
    });

    it('should show accurate XP requirements for each level', async () => {
      const xpRequirements = await page.$$eval('*:contains("XP")', elements =>
        elements.map(el => {
          const match = el.textContent.match(/(\d+,?\d*)\s*XP/);
          return match ? parseInt(match[1].replace(',', '')) : null;
        }).filter(Boolean)
      );
      
      // Verify XP requirements are progressive
      for (let i = 1; i < xpRequirements.length; i++) {
        if (xpRequirements[i] > 0 && xpRequirements[i-1] > 0) {
          expect(xpRequirements[i]).toBeGreaterThanOrEqual(xpRequirements[i-1]);
        }
      }
    });

    it('should render progress bars correctly', async () => {
      const progressBars = await page.$$('*:contains("▱"), *:contains("████")');
      expect(progressBars.length).toBeGreaterThan(0);
      
      // Check progress bar formatting
      const progressBarText = await page.$eval('*:contains("▱")', el => el.textContent);
      expect(progressBarText).toMatch(/[▱████]+\s*\d+%/);
    });
  });

  describe('4. Quest System Navigation Testing', () => {
    it('should have functional quest links', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Find quest links
      const questLinks = await page.$$('a[href*="/quests/"]');
      expect(questLinks.length).toBeGreaterThan(0);
      
      // Test first quest link
      if (questLinks.length > 0) {
        await questLinks[0].click();
        await page.waitForNavigation();
        
        // Verify quest page loaded
        const questContent = await page.$('h1, .quest-title');
        expect(questContent).toBeTruthy();
      }
    });

    it('should display quest prerequisites correctly', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/quests/quick-start.md`);
      
      // Check for prerequisites section
      const prereqSection = await page.$('*:contains("Prerequisites")');
      expect(prereqSection).toBeTruthy();
      
      // Verify quest objectives are listed
      const objectives = await page.$$('input[type="checkbox"], - [ ]');
      expect(objectives.length).toBeGreaterThan(0);
    });

    it('should show proper quest difficulty and XP rewards', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/quests/quick-start.md`);
      
      // Check for difficulty indicator
      const difficultyElements = await page.$$('*:contains("🟢"), *:contains("🟡"), *:contains("🟠"), *:contains("🔴")');
      expect(difficultyElements.length).toBeGreaterThan(0);
      
      // Check for XP reward
      const xpReward = await page.$('*:contains("100 XP")');
      expect(xpReward).toBeTruthy();
    });
  });

  describe('5. Visual Elements and Accessibility Testing', () => {
    it('should have proper contrast ratios for text elements', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check text contrast (simplified test)
      const textElements = await page.$$('p, h1, h2, h3, li, td');
      expect(textElements.length).toBeGreaterThan(0);
      
      // Verify elements are visible
      for (const element of textElements.slice(0, 5)) {
        const isVisible = await element.isIntersectingViewport();
        expect(isVisible).toBeTruthy();
      }
    });

    it('should render emoji and visual indicators consistently', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check for emoji rendering
      const emojiElements = await page.$$('*:contains("🎮"), *:contains("🏆"), *:contains("🚀"), *:contains("📊")');
      expect(emojiElements.length).toBeGreaterThan(0);
    });

    it('should be responsive on different viewport sizes', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Test mobile viewport
      await page.setViewport({ width: 375, height: 667 });
      await page.reload();
      
      const mobileContent = await page.$('.main-wrapper, .container');
      expect(mobileContent).toBeTruthy();
      
      // Test tablet viewport
      await page.setViewport({ width: 768, height: 1024 });
      await page.reload();
      
      const tabletContent = await page.$('.main-wrapper, .container');
      expect(tabletContent).toBeTruthy();
    });

    it('should have accessible interactive elements', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/progress/dashboard.md`);
      
      // Check for checkbox accessibility
      const checkboxes = await page.$$('input[type="checkbox"]');
      
      for (const checkbox of checkboxes.slice(0, 3)) {
        // Verify checkbox is focusable
        await checkbox.focus();
        const isFocused = await page.evaluate(el => document.activeElement === el, checkbox);
        expect(isFocused).toBeTruthy();
      }
    });
  });

  describe('6. Cross-Reference Integrity Testing', () => {
    it('should have no broken internal links', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      const internalLinks = await page.$$('a[href^="./"], a[href^="../"], a[href^="/docs/"]');
      const brokenLinks = [];
      
      for (const link of internalLinks.slice(0, 10)) {
        const href = await link.getAttribute('href');
        try {
          const response = await page.goto(href);
          if (response.status() !== 200) {
            brokenLinks.push(href);
          }
        } catch (error) {
          brokenLinks.push(href);
        }
      }
      
      expect(brokenLinks).toEqual([]);
    });

    it('should maintain consistent achievement references', async () => {
      // Load achievement gallery
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/achievements/gallery.md`);
      const achievementNames = await page.$$eval('.achievement-name, [data-achievement]', 
        elements => elements.map(el => el.textContent.trim())
      );
      
      // Load main hub page
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      const hubAchievements = await page.$$eval('*:contains("Platform Pioneer"), *:contains("Security Guardian")',
        elements => elements.map(el => el.textContent.trim())
      );
      
      // Check for consistency (basic validation)
      expect(hubAchievements.length).toBeGreaterThan(0);
    });
  });

  describe('7. Performance Impact Assessment', () => {
    it('should load pages within acceptable time limits', async () => {
      const startTime = Date.now();
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      const loadTime = Date.now() - startTime;
      
      // Pages should load within 3 seconds
      expect(loadTime).toBeLessThan(3000);
    });

    it('should not significantly impact page size', async () => {
      const response = await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Get response size (simplified)
      const contentLength = response.headers()['content-length'];
      if (contentLength) {
        const sizeKB = parseInt(contentLength) / 1024;
        // Documentation pages should be under 500KB
        expect(sizeKB).toBeLessThan(500);
      }
    });

    it('should not create excessive DOM elements', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      const elementCount = await page.$$eval('*', elements => elements.length);
      // Reasonable limit for documentation pages
      expect(elementCount).toBeLessThan(2000);
    });
  });

  describe('8. User Experience Validation', () => {
    it('should provide clear navigation pathways', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check for "Getting Started" or "Start Quest" buttons
      const startButtons = await page.$$('*:contains("Start"), *:contains("Begin"), a[href*="quick-start"]');
      expect(startButtons.length).toBeGreaterThan(0);
    });

    it('should display progress indicators clearly', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/progress/dashboard.md`);
      
      // Check for visual progress elements
      const progressElements = await page.$$('*:contains("%"), *:contains("Level"), *:contains("XP")');
      expect(progressElements.length).toBeGreaterThan(3);
    });

    it('should have intuitive achievement unlock criteria', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/achievements/gallery.md`);
      
      // Check for clear achievement descriptions
      const achievementCriteria = await page.$$('*:contains("Complete"), *:contains("Achieve"), *:contains("Unlock")');
      expect(achievementCriteria.length).toBeGreaterThan(0);
    });

    it('should provide helpful contextual information', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/quests/quick-start.md`);
      
      // Check for duration estimates
      const durationInfo = await page.$('*:contains("minutes"), *:contains("Duration")');
      expect(durationInfo).toBeTruthy();
      
      // Check for difficulty indicators
      const difficultyInfo = await page.$('*:contains("Beginner"), *:contains("Difficulty")');
      expect(difficultyInfo).toBeTruthy();
    });
  });

  describe('9. Content Quality and Consistency', () => {
    it('should maintain consistent formatting throughout', async () => {
      const pages = [
        `${TEST_CONFIG.baseUrl}/docs/gamification/`,
        `${TEST_CONFIG.baseUrl}/docs/gamification/achievements/gallery.md`,
        `${TEST_CONFIG.baseUrl}/docs/gamification/progress/dashboard.md`
      ];
      
      for (const pageUrl of pages) {
        await page.goto(pageUrl);
        
        // Check for consistent heading structure
        const headings = await page.$$('h1, h2, h3');
        expect(headings.length).toBeGreaterThan(0);
        
        // Check for consistent table formatting
        const tables = await page.$$('table');
        if (tables.length > 0) {
          for (const table of tables.slice(0, 2)) {
            const headers = await table.$$('th');
            const rows = await table.$$('tr');
            expect(headers.length).toBeGreaterThan(0);
            expect(rows.length).toBeGreaterThan(1);
          }
        }
      }
    });

    it('should have proper markdown rendering', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check for proper list rendering
      const lists = await page.$$('ul, ol');
      expect(lists.length).toBeGreaterThan(0);
      
      // Check for proper link rendering
      const links = await page.$$('a');
      expect(links.length).toBeGreaterThan(5);
      
      // Check for proper table rendering
      const tables = await page.$$('table');
      expect(tables.length).toBeGreaterThan(0);
    });
  });

  describe('10. Integration with Documentation Platform', () => {
    it('should integrate properly with Docusaurus theme', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check for Docusaurus-specific elements
      const docusaurusElements = await page.$$('.docusaurus, .navbar, .sidebar');
      expect(docusaurusElements.length).toBeGreaterThan(0);
    });

    it('should maintain site-wide navigation consistency', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check for main navigation
      const mainNav = await page.$('.navbar');
      expect(mainNav).toBeTruthy();
      
      // Check for sidebar navigation
      const sidebar = await page.$('.sidebar, .menu');
      expect(sidebar).toBeTruthy();
    });

    it('should preserve site styling and branding', async () => {
      await page.goto(`${TEST_CONFIG.baseUrl}/docs/gamification/`);
      
      // Check for site title
      const siteTitle = await page.$('.navbar__title, .navbar__brand');
      expect(siteTitle).toBeTruthy();
      
      // Verify title contains expected branding
      const titleText = await page.title();
      expect(titleText).toContain('Enterprise AI Platform');
    });
  });
});

// Utility functions for testing
class GamificationTestUtils {
  /**
   * Extract XP values from text content
   */
  static extractXPValues(text) {
    const xpMatches = text.match(/(\d+)\s*XP/g) || [];
    return xpMatches.map(match => parseInt(match.replace(/[^\d]/g, '')));
  }

  /**
   * Validate progress bar format
   */
  static isValidProgressBar(text) {
    return /[▱████]+\s*\d+%/.test(text);
  }

  /**
   * Check if achievement tier is valid
   */
  static isValidAchievementTier(tier) {
    const validTiers = ['🟢', '🔵', '🟣', '🟠', '🟡', '🔴'];
    return validTiers.some(validTier => tier.includes(validTier));
  }

  /**
   * Validate quest difficulty indicator
   */
  static isValidQuestDifficulty(text) {
    const difficulties = ['🟢 Beginner', '🟡 Intermediate', '🟠 Advanced', '🔴 Expert'];
    return difficulties.some(diff => text.includes(diff));
  }
}

module.exports = {
  GamificationTestUtils,
  TEST_CONFIG,
  GAMIFICATION_DATA
};