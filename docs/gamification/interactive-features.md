# Advanced Interactive Features 🎨

**Enhanced user experience with smart tooltips, recommendations, and personalization**

---

## 💬 Enhanced Tooltips & Information System

### 🔍 Smart Contextual Tooltips

#### Achievement Tooltips with Rich Information
```html
<!-- Achievement with Rich Tooltip -->
<div class="achievement-card" data-tooltip="achievement-pioneer">
  <div class="achievement-icon">🚀</div>
  <div class="achievement-name">Platform Pioneer</div>
  
  <!-- Rich Tooltip Content -->
  <div class="tooltip-content" id="tooltip-achievement-pioneer">
    <div class="tooltip-header">
      <div class="tooltip-icon">🚀</div>
      <div class="tooltip-title">
        <h3>Platform Pioneer</h3>
        <div class="tooltip-rarity common">Common Achievement</div>
      </div>
    </div>
    
    <div class="tooltip-description">
      <p>Awarded for completing your first platform quest and taking the initial steps into the Enterprise AI Platform ecosystem.</p>
    </div>
    
    <div class="tooltip-stats">
      <div class="stat-row">
        <span class="stat-label">XP Reward:</span>
        <span class="stat-value">100 XP</span>
      </div>
      <div class="stat-row">
        <span class="stat-label">Unlocked by:</span>
        <span class="stat-value">47% of users</span>
      </div>
      <div class="stat-row">
        <span class="stat-label">Average time:</span>
        <span class="stat-value">2.3 hours</span>
      </div>
    </div>
    
    <div class="tooltip-progression">
      <h4>What this unlocks:</h4>
      <ul>
        <li>➡️ Access to Explorer learning track</li>
        <li>➡️ Architecture Explorer achievement path</li>
        <li>➡️ Team collaboration features</li>
      </ul>
    </div>
    
    <div class="tooltip-tips">
      <h4>💡 Pro Tip:</h4>
      <p>Complete the Platform Overview quest next for the most efficient XP gain and optimal learning progression.</p>
    </div>
  </div>
</div>
```

#### Task Tooltips with Context and Hints
```html
<!-- Task with Contextual Tooltip -->
<div class="task-item" data-tooltip="task-deployment">
  <div class="task-content">
    <div class="task-title">🚀 Deploy first service</div>
    <div class="task-meta">+40 XP • ~20 min</div>
  </div>
  
  <!-- Contextual Task Tooltip -->
  <div class="tooltip-content" id="tooltip-task-deployment">
    <div class="tooltip-header">
      <h3>🚀 Service Deployment Guide</h3>
      <div class="difficulty-indicator medium">Intermediate</div>
    </div>
    
    <div class="tooltip-quick-steps">
      <h4>Quick Steps:</h4>
      <ol>
        <li>Navigate to <code>/apps/api-gateway</code></li>
        <li>Run <code>docker-compose up -d</code></li>
        <li>Verify with <code>curl localhost:3000/health</code></li>
        <li>Check logs for any errors</li>
      </ol>
    </div>
    
    <div class="tooltip-resources">
      <h4>📁 Helpful Resources:</h4>
      <div class="resource-links">
        <a href="#deployment-guide" class="resource-link">
          📜 Deployment Guide
        </a>
        <a href="#troubleshooting" class="resource-link">
          🔧 Troubleshooting
        </a>
        <a href="#docker-basics" class="resource-link">
          🐳 Docker Basics
        </a>
      </div>
    </div>
    
    <div class="tooltip-prerequisites">
      <h4>⚙️ Prerequisites:</h4>
      <div class="prereq-list">
        <div class="prereq completed">
          ✓ Docker installed and running
        </div>
        <div class="prereq completed">
          ✓ Environment setup complete
        </div>
        <div class="prereq warning">
          ⚠️ Port 3000 available
        </div>
      </div>
    </div>
    
    <div class="tooltip-rewards">
      <h4>🏆 Completion Rewards:</h4>
      <ul>
        <li>+40 XP (base reward)</li>
        <li>+10 XP (first deployment bonus)</li>
        <li>Progress toward Environment Builder achievement</li>
        <li>Unlock: Testing Advocate quest</li>
      </ul>
    </div>
  </div>
</div>
```

#### Progress Bar Tooltips with Detailed Breakdown
```html
<!-- Progress Bar with Detailed Tooltip -->
<div class="progress-container" data-tooltip="xp-breakdown">
  <div class="progress-label">🎯 Level Progress</div>
  <div class="progress-bar">
    <div class="progress-fill" style="width: 56%"></div>
    <div class="progress-text">1,400 / 2,500 XP</div>
  </div>
  
  <!-- Detailed XP Breakdown Tooltip -->
  <div class="tooltip-content" id="tooltip-xp-breakdown">
    <div class="tooltip-header">
      <h3>📊 XP Breakdown & Analysis</h3>
    </div>
    
    <div class="xp-sources">
      <h4>XP Sources (Last 7 Days):</h4>
      <div class="xp-source-chart">
        <div class="source-item">
          <div class="source-bar quest" style="width: 60%"></div>
          <span class="source-label">Quest Completion</span>
          <span class="source-value">240 XP (60%)</span>
        </div>
        <div class="source-item">
          <div class="source-bar bonus" style="width: 25%"></div>
          <span class="source-label">Quality Bonuses</span>
          <span class="source-value">100 XP (25%)</span>
        </div>
        <div class="source-item">
          <div class="source-bar streak" style="width: 15%"></div>
          <span class="source-label">Streak Multipliers</span>
          <span class="source-value">60 XP (15%)</span>
        </div>
      </div>
    </div>
    
    <div class="level-projection">
      <h4>Level Progression Forecast:</h4>
      <div class="projection-stats">
        <div class="projection-item">
          <span class="proj-label">At current pace:</span>
          <span class="proj-value">Level 5 in 8 days</span>
        </div>
        <div class="projection-item">
          <span class="proj-label">Optimized path:</span>
          <span class="proj-value">Level 5 in 5 days</span>
        </div>
        <div class="projection-item">
          <span class="proj-label">XP needed:</span>
          <span class="proj-value">1,100 XP remaining</span>
        </div>
      </div>
    </div>
    
    <div class="optimization-tips">
      <h4>💡 Optimization Tips:</h4>
      <ul>
        <li>Focus on Infrastructure track (your strongest area)</li>
        <li>Maintain 7+ day streak for 25% bonus</li>
        <li>Complete optional tasks for quality bonuses</li>
      </ul>
    </div>
  </div>
</div>
```

### 🌈 Advanced Hover Effects

#### Multi-Layer Achievement Cards
```html
<!-- Hoverable Achievement Card -->
<div class="achievement-card-advanced" data-achievement="security-guardian">
  <div class="card-background"></div>
  <div class="card-glow"></div>
  
  <div class="card-content">
    <div class="achievement-tier epic">EPIC</div>
    <div class="achievement-icon">🛑</div>
    <div class="achievement-name">Security Guardian</div>
    <div class="achievement-xp">500 XP</div>
  </div>
  
  <div class="card-hover-overlay">
    <div class="hover-actions">
      <button class="action-btn view-details">🔍 View Details</button>
      <button class="action-btn share-achievement">📤 Share</button>
    </div>
    <div class="achievement-preview">
      <p>Master comprehensive security implementation</p>
      <div class="progress-preview">
        <span>Progress: 73% complete</span>
        <div class="mini-progress-bar">
          <div class="mini-fill" style="width: 73%"></div>
        </div>
      </div>
    </div>
  </div>
</div>
```

---

## 🤖 Smart Achievement Recommendation System

### 🎯 Intelligent Achievement Suggestions

#### Personalized Recommendation Engine
```html
<!-- Smart Recommendations Dashboard -->
<div class="recommendation-engine">
  <div class="engine-header">
    <h2>🤖 Smart Achievement Recommendations</h2>
    <div class="engine-status">
      <span class="status-indicator active"></span>
      <span>AI Analysis Active</span>
    </div>
  </div>
  
  <!-- Priority Recommendations -->
  <div class="recommendations-section priority">
    <h3>🎆 High-Priority Recommendations</h3>
    <p class="section-desc">Based on your current progress and goals</p>
    
    <div class="recommendation-card high-priority">
      <div class="rec-header">
        <div class="rec-icon">⚙️</div>
        <div class="rec-info">
          <h4>Environment Builder</h4>
          <div class="rec-meta">
            <span class="rec-xp">200 XP</span>
            <span class="rec-difficulty">Easy</span>
            <span class="rec-time">~15 min</span>
          </div>
        </div>
        <div class="rec-priority">🔥 Hot</div>
      </div>
      
      <div class="rec-analysis">
        <div class="analysis-reason">
          <strong>Why now:</strong> You're 90% complete with prerequisites and have the necessary setup skills.
        </div>
        <div class="analysis-benefit">
          <strong>Key benefit:</strong> Unlocks entire Development track + 3 new achievements.
        </div>
      </div>
      
      <div class="rec-progress">
        <div class="progress-label">Requirements Progress</div>
        <div class="req-progress-bar">
          <div class="req-fill" style="width: 90%"></div>
          <span class="req-text">9/10 requirements met</span>
        </div>
        <div class="missing-req">
          <span class="req-item pending">⏳ Complete environment verification</span>
        </div>
      </div>
      
      <div class="rec-actions">
        <button class="rec-btn primary">🚀 Start Now</button>
        <button class="rec-btn secondary">📊 View Details</button>
        <button class="rec-btn tertiary">❌ Dismiss</button>
      </div>
    </div>
    
    <div class="recommendation-card medium-priority">
      <div class="rec-header">
        <div class="rec-icon">🧪</div>
        <div class="rec-info">
          <h4>Testing Advocate</h4>
          <div class="rec-meta">
            <span class="rec-xp">125 XP</span>
            <span class="rec-difficulty">Medium</span>
            <span class="rec-time">~30 min</span>
          </div>
        </div>
        <div class="rec-priority">⭐ Good</div>
      </div>
      
      <div class="rec-analysis">
        <div class="analysis-reason">
          <strong>Why recommended:</strong> Aligns with your development interests and strengthens quality practices.
        </div>
        <div class="analysis-impact">
          <strong>Career impact:</strong> High-demand skill with excellent XP-to-effort ratio.
        </div>
      </div>
      
      <div class="rec-actions">
        <button class="rec-btn primary">🎯 Queue Next</button>
        <button class="rec-btn secondary">📋 Learn More</button>
      </div>
    </div>
  </div>
  
  <!-- Quick Wins Section -->
  <div class="recommendations-section quick-wins">
    <h3>⚡ Quick Wins (High XP, Low Effort)</h3>
    <div class="quick-win-grid">
      <div class="quick-win-card">
        <div class="qw-icon">📚</div>
        <div class="qw-details">
          <h4>Documentation Reader</h4>
          <div class="qw-stats">+75 XP • 10 min</div>
          <div class="qw-desc">Read 3 more docs (7/10 complete)</div>
        </div>
        <button class="qw-action">🚀 Go</button>
      </div>
      
      <div class="quick-win-card">
        <div class="qw-icon">🔧</div>
        <div class="qw-details">
          <h4>Tool Explorer</h4>
          <div class="qw-stats">+100 XP • 15 min</div>
          <div class="qw-desc">Try the new monitoring dashboard</div>
        </div>
        <button class="qw-action">🚀 Try</button>
      </div>
      
      <div class="quick-win-card">
        <div class="qw-icon">🌟</div>
        <div class="qw-details">
          <h4>Quality Bonus</h4>
          <div class="qw-stats">+50 XP • 5 min</div>
          <div class="qw-desc">Add comments to your last deployment</div>
        </div>
        <button class="qw-action">✨ Polish</button>
      </div>
    </div>
  </div>
  
  <!-- Strategic Path Recommendations -->
  <div class="recommendations-section strategic">
    <h3>🗺️ Strategic Learning Paths</h3>
    <div class="strategic-paths">
      <div class="strategy-card infrastructure">
        <div class="strategy-header">
          <div class="strategy-icon">🏗️</div>
          <div class="strategy-title">
            <h4>Infrastructure Specialist Path</h4>
            <div class="strategy-match">95% match for your interests</div>
          </div>
        </div>
        
        <div class="strategy-analysis">
          <div class="strength-analysis">
            <strong>Your strengths:</strong> Strong in containerization, good deployment skills
          </div>
          <div class="path-benefits">
            <strong>Path benefits:</strong> 1,200 XP total, high-demand career skills, 6 achievements
          </div>
        </div>
        
        <div class="path-progression">
          <div class="progression-step completed">
            <span class="step-icon">✓</span>
            <span class="step-name">Container Captain</span>
          </div>
          <div class="progression-step current">
            <span class="step-icon">🎯</span>
            <span class="step-name">Security Guardian (73%)</span>
          </div>
          <div class="progression-step pending">
            <span class="step-icon">⏳</span>
            <span class="step-name">Observability Expert</span>
          </div>
        </div>
        
        <button class="strategy-btn">🛤️ Follow This Path</button>
      </div>
      
      <div class="strategy-card development">
        <div class="strategy-header">
          <div class="strategy-icon">💻</div>
          <div class="strategy-title">
            <h4>Full-Stack Development Path</h4>
            <div class="strategy-match">78% match for your interests</div>
          </div>
        </div>
        
        <div class="strategy-analysis">
          <div class="growth-opportunity">
            <strong>Growth area:</strong> Would expand your skillset into API design and testing
          </div>
          <div class="time-investment">
            <strong>Time investment:</strong> Medium (4-6 weeks), good ROI
          </div>
        </div>
        
        <button class="strategy-btn secondary">📋 Explore Path</button>
      </div>
    </div>
  </div>
</div>
```

### 🕰️ Time-Based Smart Recommendations

#### Daily Optimization Engine
```html
<!-- Daily Smart Recommendations -->
<div class="daily-optimization">
  <div class="daily-header">
    <h3>🌅 Today's Optimized Plan</h3>
    <div class="daily-meta">
      <span class="available-time">45 min available</span>
      <span class="energy-level high">💪 High energy</span>
      <span class="streak-day">Day 8 streak</span>
    </div>
  </div>
  
  <div class="optimization-plan">
    <div class="time-block morning">
      <div class="time-header">
        <h4>🌅 Morning Session (20 min)</h4>
        <div class="optimal-indicator">✨ Peak focus time</div>
      </div>
      
      <div class="recommended-activity">
        <div class="activity-card">
          <div class="activity-icon">🚀</div>
          <div class="activity-details">
            <h5>Complete Service Deployment</h5>
            <div class="activity-reasoning">
              Complex task scheduled for peak focus time
            </div>
            <div class="activity-rewards">
              +40 XP + completion bonus
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="time-block afternoon">
      <div class="time-header">
        <h4>☀️ Afternoon Session (15 min)</h4>
        <div class="optimal-indicator">📚 Good for learning</div>
      </div>
      
      <div class="recommended-activity">
        <div class="activity-card">
          <div class="activity-icon">📚</div>
          <div class="activity-details">
            <h5>Read Architecture Documentation</h5>
            <div class="activity-reasoning">
              Low-effort, high-value learning activity
            </div>
            <div class="activity-rewards">
              +25 XP + progress toward Documentation Reader
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="time-block evening">
      <div class="time-header">
        <h4>🌆 Evening Session (10 min)</h4>
        <div class="optimal-indicator">✅ Wrap-up time</div>
      </div>
      
      <div class="recommended-activity">
        <div class="activity-card">
          <div class="activity-icon">📋</div>
          <div class="activity-details">
            <h5>Daily Reflection & Planning</h5>
            <div class="activity-reasoning">
              Maintain streak and plan tomorrow
            </div>
            <div class="activity-rewards">
              +15 XP + streak maintenance
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="plan-summary">
    <div class="summary-stats">
      <div class="stat">
        <span class="stat-value">80 XP</span>
        <span class="stat-label">Expected gain</span>
      </div>
      <div class="stat">
        <span class="stat-value">2</span>
        <span class="stat-label">Achievement progress</span>
      </div>
      <div class="stat">
        <span class="stat-value">95%</span>
        <span class="stat-label">Success probability</span>
      </div>
    </div>
    
    <div class="plan-actions">
      <button class="plan-btn accept">🎯 Accept Plan</button>
      <button class="plan-btn customize">⚙️ Customize</button>
      <button class="plan-btn refresh">🔄 Regenerate</button>
    </div>
  </div>
</div>
```

---

## 🔥 Dynamic Streak & Momentum System

### 📅 Advanced Streak Tracking

#### Comprehensive Streak Dashboard
```html
<!-- Advanced Streak Tracker -->
<div class="streak-dashboard">
  <div class="streak-header">
    <div class="streak-flame">🔥</div>
    <div class="streak-info">
      <h2>8-Day Learning Streak!</h2>
      <div class="streak-subtitle">You're building amazing momentum</div>
    </div>
    <div class="streak-multiplier">
      <div class="multiplier-value">1.25x</div>
      <div class="multiplier-label">XP Bonus</div>
    </div>
  </div>
  
  <div class="streak-calendar">
    <div class="calendar-header">
      <h3>This Week's Activity</h3>
      <div class="week-stats">425 XP earned (+15% vs last week)</div>
    </div>
    
    <div class="calendar-days">
      <div class="calendar-day completed high-activity" data-date="2024-01-15">
        <div class="day-indicator">🔥</div>
        <div class="day-label">Mon</div>
        <div class="day-xp">85 XP</div>
        <div class="day-activities">
          <span class="activity-dot quest"></span>
          <span class="activity-dot achievement"></span>
          <span class="activity-dot bonus"></span>
        </div>
      </div>
      
      <div class="calendar-day completed medium-activity" data-date="2024-01-16">
        <div class="day-indicator">🔥</div>
        <div class="day-label">Tue</div>
        <div class="day-xp">65 XP</div>
        <div class="day-activities">
          <span class="activity-dot quest"></span>
          <span class="activity-dot documentation"></span>
        </div>
      </div>
      
      <div class="calendar-day completed high-activity" data-date="2024-01-17">
        <div class="day-indicator">🔥</div>
        <div class="day-label">Wed</div>
        <div class="day-xp">95 XP</div>
        <div class="day-activities">
          <span class="activity-dot quest"></span>
          <span class="activity-dot achievement"></span>
          <span class="activity-dot testing"></span>
        </div>
      </div>
      
      <div class="calendar-day completed medium-activity" data-date="2024-01-18">
        <div class="day-indicator">🔥</div>
        <div class="day-label">Thu</div>
        <div class="day-xp">55 XP</div>
        <div class="day-activities">
          <span class="activity-dot documentation"></span>
          <span class="activity-dot bonus"></span>
        </div>
      </div>
      
      <div class="calendar-day completed high-activity" data-date="2024-01-19">
        <div class="day-indicator">🔥</div>
        <div class="day-label">Fri</div>
        <div class="day-xp">80 XP</div>
        <div class="day-activities">
          <span class="activity-dot quest"></span>
          <span class="activity-dot deployment"></span>
        </div>
      </div>
      
      <div class="calendar-day completed low-activity" data-date="2024-01-20">
        <div class="day-indicator">🔥</div>
        <div class="day-label">Sat</div>
        <div class="day-xp">25 XP</div>
        <div class="day-activities">
          <span class="activity-dot reading"></span>
        </div>
      </div>
      
      <div class="calendar-day completed medium-activity" data-date="2024-01-21">
        <div class="day-indicator">🔥</div>
        <div class="day-label">Sun</div>
        <div class="day-xp">45 XP</div>
        <div class="day-activities">
          <span class="activity-dot documentation"></span>
          <span class="activity-dot planning"></span>
        </div>
      </div>
      
      <div class="calendar-day current" data-date="2024-01-22">
        <div class="day-indicator current">🎯</div>
        <div class="day-label">Today</div>
        <div class="day-target">Goal: 60 XP</div>
        <div class="day-progress">
          <div class="progress-ring">
            <div class="progress-circle" style="stroke-dasharray: 45 100"></div>
          </div>
          <span class="progress-text">45%</span>
        </div>
      </div>
    </div>
  </div>
  
  <div class="streak-milestones">
    <h3>Streak Milestones & Rewards</h3>
    <div class="milestone-track">
      <div class="milestone achieved" data-days="3">
        <div class="milestone-icon">✓</div>
        <div class="milestone-label">3 days</div>
        <div class="milestone-reward">+10% XP</div>
      </div>
      
      <div class="milestone achieved" data-days="7">
        <div class="milestone-icon">✓</div>
        <div class="milestone-label">7 days</div>
        <div class="milestone-reward">+25% XP</div>
      </div>
      
      <div class="milestone current" data-days="14">
        <div class="milestone-icon">🎯</div>
        <div class="milestone-label">14 days</div>
        <div class="milestone-reward">+50% XP + Badge</div>
        <div class="milestone-progress">6 days to go</div>
      </div>
      
      <div class="milestone future" data-days="30">
        <div class="milestone-icon">🔒</div>
        <div class="milestone-label">30 days</div>
        <div class="milestone-reward">Streak Master + 300 XP</div>
      </div>
      
      <div class="milestone future legendary" data-days="100">
        <div class="milestone-icon">🔒</div>
        <div class="milestone-label">100 days</div>
        <div class="milestone-reward">Dedication Legend + 1000 XP</div>
      </div>
    </div>
  </div>
  
  <div class="streak-insights">
    <div class="insight-cards">
      <div class="insight-card positive">
        <div class="insight-icon">📈</div>
        <div class="insight-content">
          <h4>Strong Momentum</h4>
          <p>Your consistency has improved 40% over the last month. Keep it up!</p>
        </div>
      </div>
      
      <div class="insight-card tip">
        <div class="insight-icon">💡</div>
        <div class="insight-content">
          <h4>Optimization Tip</h4>
          <p>Tuesday is your most productive day. Consider scheduling complex tasks then.</p>
        </div>
      </div>
      
      <div class="insight-card warning">
        <div class="insight-icon">⚠️</div>
        <div class="insight-content">
          <h4>Weekend Pattern</h4>
          <p>Lower activity on weekends. Set a 30 XP minimum to maintain streaks.</p>
        </div>
      </div>
    </div>
  </div>
</div>
```

### 💪 Momentum Indicators

#### Learning Velocity Tracker
```html
<!-- Momentum Tracker -->
<div class="momentum-tracker">
  <div class="momentum-header">
    <h3>🏆 Learning Momentum Analysis</h3>
    <div class="momentum-status excellent">
      <div class="status-indicator"></div>
      <span>Excellent Momentum</span>
    </div>
  </div>
  
  <div class="velocity-metrics">
    <div class="metric-card">
      <div class="metric-icon">⚡</div>
      <div class="metric-content">
        <div class="metric-value">2.3x</div>
        <div class="metric-label">Velocity Multiplier</div>
        <div class="metric-subtitle">vs platform average</div>
      </div>
    </div>
    
    <div class="metric-card">
      <div class="metric-icon">🏃</div>
      <div class="metric-content">
        <div class="metric-value">85</div>
        <div class="metric-label">Daily XP Average</div>
        <div class="metric-subtitle">7-day rolling average</div>
      </div>
    </div>
    
    <div class="metric-card">
      <div class="metric-icon">📈</div>
      <div class="metric-content">
        <div class="metric-value">+15%</div>
        <div class="metric-label">Weekly Growth</div>
        <div class="metric-subtitle">trending upward</div>
      </div>
    </div>
  </div>
  
  <div class="momentum-chart">
    <canvas id="momentum-chart" width="500" height="200"></canvas>
  </div>
  
  <div class="momentum-insights">
    <h4>📊 Momentum Insights</h4>
    <div class="insights-grid">
      <div class="insight-item positive">
        <div class="insight-bullet"></div>
        <span>Consistent daily engagement building strong habits</span>
      </div>
      <div class="insight-item positive">
        <span>Quality completion rate above 90% indicates deep learning</span>
      </div>
      <div class="insight-item opportunity">
        <span>Weekend activity could be optimized for better momentum</span>
      </div>
    </div>
  </div>
</div>
```

---

## 🎨 User Customization & Preferences

### ⚙️ Comprehensive Settings Panel

#### Personalization Dashboard
```html
<!-- User Customization Panel -->
<div class="customization-panel">
  <div class="settings-header">
    <h2>⚙️ Personalization Center</h2>
    <div class="settings-nav">
      <button class="nav-btn active" data-section="appearance">Appearance</button>
      <button class="nav-btn" data-section="notifications">Notifications</button>
      <button class="nav-btn" data-section="goals">Goals</button>
      <button class="nav-btn" data-section="privacy">Privacy</button>
    </div>
  </div>
  
  <!-- Appearance Settings -->
  <div class="settings-section" id="appearance-settings">
    <h3>🎨 Visual Theme & Layout</h3>
    
    <div class="theme-selector">
      <h4>Dashboard Theme</h4>
      <div class="theme-grid">
        <div class="theme-option" data-theme="space-explorer">
          <div class="theme-preview space-explorer">
            <div class="preview-header"></div>
            <div class="preview-content">
              <div class="preview-bar"></div>
              <div class="preview-achievement"></div>
            </div>
          </div>
          <div class="theme-name">Space Explorer</div>
          <div class="theme-status current">Current</div>
        </div>
        
        <div class="theme-option" data-theme="champion">
          <div class="theme-preview champion">
            <div class="preview-header"></div>
            <div class="preview-content">
              <div class="preview-bar"></div>
              <div class="preview-achievement"></div>
            </div>
          </div>
          <div class="theme-name">Champion Gold</div>
        </div>
        
        <div class="theme-option" data-theme="nature">
          <div class="theme-preview nature">
            <div class="preview-header"></div>
            <div class="preview-content">
              <div class="preview-bar"></div>
              <div class="preview-achievement"></div>
            </div>
          </div>
          <div class="theme-name">Nature Zen</div>
        </div>
        
        <div class="theme-option" data-theme="professional">
          <div class="theme-preview professional">
            <div class="preview-header"></div>
            <div class="preview-content">
              <div class="preview-bar"></div>
              <div class="preview-achievement"></div>
            </div>
          </div>
          <div class="theme-name">Professional</div>
        </div>
      </div>
    </div>
    
    <div class="animation-preferences">
      <h4>Animation & Effects</h4>
      <div class="preference-group">
        <div class="preference-item">
          <label class="preference-label">
            <input type="radio" name="celebration-style" value="full" checked>
            <span class="radio-custom"></span>
            🎉 Full Celebration
            <small>Confetti, sound, and animations</small>
          </label>
        </div>
        
        <div class="preference-item">
          <label class="preference-label">
            <input type="radio" name="celebration-style" value="subtle">
            <span class="radio-custom"></span>
            ⚡ Quick Flash
            <small>Subtle visual feedback only</small>
          </label>
        </div>
        
        <div class="preference-item">
          <label class="preference-label">
            <input type="radio" name="celebration-style" value="minimal">
            <span class="radio-custom"></span>
            📱 Minimal
            <small>Text notifications only</small>
          </label>
        </div>
        
        <div class="preference-item">
          <label class="preference-label">
            <input type="checkbox" name="reduce-motion">
            <span class="checkbox-custom"></span>
            Reduce motion for accessibility
          </label>
        </div>
      </div>
    </div>
    
    <div class="layout-preferences">
      <h4>Dashboard Layout</h4>
      <div class="layout-options">
        <div class="layout-option">
          <input type="radio" name="layout" value="compact" id="layout-compact">
          <label for="layout-compact" class="layout-label">
            <div class="layout-preview compact">
              <div class="layout-section"></div>
              <div class="layout-section"></div>
              <div class="layout-section"></div>
            </div>
            <span>Compact</span>
          </label>
        </div>
        
        <div class="layout-option">
          <input type="radio" name="layout" value="balanced" id="layout-balanced" checked>
          <label for="layout-balanced" class="layout-label">
            <div class="layout-preview balanced">
              <div class="layout-section"></div>
              <div class="layout-section"></div>
            </div>
            <span>Balanced</span>
          </label>
        </div>
        
        <div class="layout-option">
          <input type="radio" name="layout" value="spacious" id="layout-spacious">
          <label for="layout-spacious" class="layout-label">
            <div class="layout-preview spacious">
              <div class="layout-section"></div>
            </div>
            <span>Spacious</span>
          </label>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Notification Settings -->
  <div class="settings-section" id="notification-settings" style="display: none;">
    <h3>🔔 Notification Preferences</h3>
    
    <div class="notification-categories">
      <div class="notification-category">
        <div class="category-header">
          <h4>🏆 Achievements & Milestones</h4>
          <label class="toggle-switch">
            <input type="checkbox" checked>
            <span class="toggle-slider"></span>
          </label>
        </div>
        
        <div class="category-options">
          <div class="notification-option">
            <label class="option-label">
              <input type="checkbox" checked>
              <span class="checkbox-custom"></span>
              Achievement unlocks
            </label>
            <div class="option-details">
              <select class="delivery-method">
                <option>Desktop notification + Sound</option>
                <option>Desktop notification only</option>
                <option>In-app only</option>
              </select>
            </div>
          </div>
          
          <div class="notification-option">
            <label class="option-label">
              <input type="checkbox" checked>
              <span class="checkbox-custom"></span>
              Level ups
            </label>
            <div class="option-details">
              <select class="delivery-method">
                <option>Desktop notification + Animation</option>
                <option>In-app celebration</option>
              </select>
            </div>
          </div>
          
          <div class="notification-option">
            <label class="option-label">
              <input type="checkbox">
              <span class="checkbox-custom"></span>
              Progress milestones
            </label>
          </div>
        </div>
      </div>
      
      <div class="notification-category">
        <div class="category-header">
          <h4>🎯 Tasks & Quests</h4>
          <label class="toggle-switch">
            <input type="checkbox" checked>
            <span class="toggle-slider"></span>
          </label>
        </div>
        
        <div class="category-options">
          <div class="notification-option">
            <label class="option-label">
              <input type="checkbox" checked>
              <span class="checkbox-custom"></span>
              New quests available
            </label>
          </div>
          
          <div class="notification-option">
            <label class="option-label">
              <input type="checkbox">
              <span class="checkbox-custom"></span>
              Quest completion reminders
            </label>
            <div class="option-timing">
              <select>
                <option>After 1 day of inactivity</option>
                <option>After 3 days of inactivity</option>
                <option>Weekly summary only</option>
              </select>
            </div>
          </div>
        </div>
      </div>
      
      <div class="notification-category">
        <div class="category-header">
          <h4>🔥 Streaks & Momentum</h4>
          <label class="toggle-switch">
            <input type="checkbox" checked>
            <span class="toggle-slider"></span>
          </label>
        </div>
        
        <div class="category-options">
          <div class="notification-option">
            <label class="option-label">
              <input type="checkbox" checked>
              <span class="checkbox-custom"></span>
              Daily streak reminders
            </label>
            <div class="option-timing">
              <input type="time" value="18:00"> daily
            </div>
          </div>
          
          <div class="notification-option">
            <label class="option-label">
              <input type="checkbox" checked>
              <span class="checkbox-custom"></span>
              Streak milestones
            </label>
          </div>
        </div>
      </div>
    </div>
    
    <div class="notification-schedule">
      <h4>📅 Delivery Schedule</h4>
      <div class="schedule-options">
        <div class="schedule-item">
          <label>Quiet hours:</label>
          <div class="time-range">
            <input type="time" value="22:00"> to <input type="time" value="08:00">
          </div>
        </div>
        
        <div class="schedule-item">
          <label>Weekend delivery:</label>
          <select>
            <option>Same as weekdays</option>
            <option>Reduced frequency</option>
            <option>Summary only</option>
          </select>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Goals Settings -->
  <div class="settings-section" id="goals-settings" style="display: none;">
    <h3>🎯 Personal Goals & Targets</h3>
    
    <div class="goal-setting">
      <div class="goal-category">
        <h4>Daily Targets</h4>
        <div class="goal-input-group">
          <label>Daily XP Goal:</label>
          <div class="input-with-slider">
            <input type="range" min="25" max="200" value="75" class="goal-slider">
            <input type="number" value="75" class="goal-number"> XP
          </div>
          <div class="goal-feedback">
            <span class="feedback-text">Moderate goal - achievable with 20-30 min daily</span>
          </div>
        </div>
        
        <div class="goal-input-group">
          <label>Minimum Streak Activity:</label>
          <select class="goal-select">
            <option value="15">15 XP (reading/quick task)</option>
            <option value="30" selected>30 XP (substantial activity)</option>
            <option value="50">50 XP (dedicated session)</option>
          </select>
        </div>
      </div>
      
      <div class="goal-category">
        <h4>Weekly Objectives</h4>
        <div class="goal-input-group">
          <label>Quests per week:</label>
          <select class="goal-select">
            <option value="1">1 quest (casual pace)</option>
            <option value="2" selected>2 quests (steady progress)</option>
            <option value="3">3 quests (intensive learning)</option>
          </select>
        </div>
        
        <div class="goal-input-group">
          <label>Focus area:</label>
          <select class="goal-select">
            <option value="balanced">Balanced across all tracks</option>
            <option value="infrastructure" selected>Infrastructure specialization</option>
            <option value="development">Development focus</option>
            <option value="aiml">AI/ML concentration</option>
            <option value="operations">Operations mastery</option>
          </select>
        </div>
      </div>
      
      <div class="goal-category">
        <h4>Long-term Aspirations</h4>
        <div class="aspiration-selector">
          <div class="aspiration-card">
            <input type="checkbox" id="specialization-goal" checked>
            <label for="specialization-goal" class="aspiration-label">
              <div class="aspiration-icon">🏆</div>
              <div class="aspiration-content">
                <h5>Achieve Specialization</h5>
                <p>Complete Infrastructure Specialist path</p>
                <div class="aspiration-timeline">Target: 6-8 weeks</div>
              </div>
            </label>
          </div>
          
          <div class="aspiration-card">
            <input type="checkbox" id="mentor-goal">
            <label for="mentor-goal" class="aspiration-label">
              <div class="aspiration-icon">🎓</div>
              <div class="aspiration-content">
                <h5>Become a Mentor</h5>
                <p>Guide other learners and share knowledge</p>
                <div class="aspiration-timeline">Target: 3 months</div>
              </div>
            </label>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="settings-footer">
    <button class="settings-btn save">💾 Save Preferences</button>
    <button class="settings-btn reset">🔄 Reset to Defaults</button>
    <button class="settings-btn export">📤 Export Settings</button>
  </div>
</div>
```

---

**🎮 Interactive features complete! This comprehensive system provides:**

- **Smart tooltips** with contextual information and guidance
- **Intelligent recommendations** based on user behavior and progress
- **Advanced streak tracking** with momentum analysis
- **Comprehensive customization** for personalized experience
- **Mobile-optimized interactions** with touch-friendly interfaces
- **Real-time feedback** with celebrations and notifications

*These features create an engaging, personalized, and highly interactive gamification experience that adapts to each user's learning style and preferences.*