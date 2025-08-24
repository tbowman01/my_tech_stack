# Interactive Skill Tree Visualization 🌳

**Visual learning paths with interactive unlock progression and mastery tracking**

---

## 🎮 Complete Skill Tree System

### 🌳 Master Skill Tree Overview

#### Full Platform Mastery Tree
```html
<!-- Master Skill Tree Container -->
<div class="skill-tree-container">
  <div class="skill-tree-header">
    <h1>🌳 Platform Mastery Tree</h1>
    <div class="tree-stats">
      <div class="tree-stat">
        <span class="stat-value">15</span>
        <span class="stat-label">Skills Unlocked</span>
      </div>
      <div class="tree-stat">
        <span class="stat-value">42</span>
        <span class="stat-label">Total Skills</span>
      </div>
      <div class="tree-stat">
        <span class="stat-value">36%</span>
        <span class="stat-label">Tree Complete</span>
      </div>
    </div>
  </div>
  
  <div class="skill-tree-controls">
    <div class="view-controls">
      <button class="view-btn active" data-view="full">Full Tree</button>
      <button class="view-btn" data-view="unlocked">My Progress</button>
      <button class="view-btn" data-view="recommended">Recommended Path</button>
    </div>
    
    <div class="tree-filters">
      <button class="filter-btn" data-branch="all">All Branches</button>
      <button class="filter-btn" data-branch="infrastructure">Infrastructure</button>
      <button class="filter-btn" data-branch="development">Development</button>
      <button class="filter-btn" data-branch="aiml">AI/ML</button>
      <button class="filter-btn" data-branch="operations">Operations</button>
    </div>
  </div>
  
  <!-- Main Skill Tree Visualization -->
  <div class="skill-tree-canvas">
    <svg class="skill-connections" viewBox="0 0 1200 800">
      <!-- Connection Lines Between Skills -->
      <defs>
        <linearGradient id="unlockedGradient" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" style="stop-color:#00d4aa;stop-opacity:1" />
          <stop offset="100%" style="stop-color:#0084d4;stop-opacity:1" />
        </linearGradient>
        <linearGradient id="lockedGradient" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" style="stop-color:#666;stop-opacity:0.3" />
          <stop offset="100%" style="stop-color:#888;stop-opacity:0.3" />
        </linearGradient>
      </defs>
      
      <!-- Foundation to Infrastructure Branch -->
      <path class="skill-path unlocked" d="M 600 700 L 300 500" stroke="url(#unlockedGradient)" />
      <path class="skill-path unlocked" d="M 300 500 L 150 350" stroke="url(#unlockedGradient)" />
      <path class="skill-path unlocked" d="M 300 500 L 300 300" stroke="url(#unlockedGradient)" />
      <path class="skill-path current" d="M 300 300 L 250 200" stroke="url(#unlockedGradient)" stroke-dasharray="5,5" />
      <path class="skill-path locked" d="M 250 200 L 200 100" stroke="url(#lockedGradient)" />
      
      <!-- Foundation to Development Branch -->
      <path class="skill-path unlocked" d="M 600 700 L 600 500" stroke="url(#unlockedGradient)" />
      <path class="skill-path partial" d="M 600 500 L 650 350" stroke="url(#unlockedGradient)" stroke-dasharray="10,5" />
      <path class="skill-path locked" d="M 650 350 L 700 200" stroke="url(#lockedGradient)" />
      
      <!-- Foundation to AI/ML Branch -->
      <path class="skill-path unlocked" d="M 600 700 L 900 500" stroke="url(#unlockedGradient)" />
      <path class="skill-path locked" d="M 900 500 L 950 350" stroke="url(#lockedGradient)" />
      <path class="skill-path locked" d="M 950 350 L 1000 200" stroke="url(#lockedGradient)" />
      
      <!-- Mastery Connections -->
      <path class="skill-path master-locked" d="M 200 100 L 600 50" stroke="url(#lockedGradient)" />
      <path class="skill-path master-locked" d="M 700 200 L 600 50" stroke="url(#lockedGradient)" />
      <path class="skill-path master-locked" d="M 1000 200 L 600 50" stroke="url(#lockedGradient)" />
    </svg>
    
    <!-- Skill Nodes Overlay -->
    <div class="skill-nodes">
      <!-- Foundation Node (Starting Point) -->
      <div class="skill-node foundation unlocked" style="top: 670px; left: 580px;" data-skill="foundation">
        <div class="node-ring completed"></div>
        <div class="node-icon">🌱</div>
        <div class="node-label">Platform Foundation</div>
        <div class="node-progress">100%</div>
        <div class="node-xp">+150 XP</div>
      </div>
      
      <!-- Infrastructure Branch -->
      <div class="skill-node infrastructure unlocked" style="top: 470px; left: 280px;" data-skill="docker">
        <div class="node-ring completed"></div>
        <div class="node-icon">🐳</div>
        <div class="node-label">Docker Mastery</div>
        <div class="node-progress">100%</div>
        <div class="node-xp">+200 XP</div>
      </div>
      
      <div class="skill-node infrastructure unlocked" style="top: 320px; left: 130px;" data-skill="kubernetes">
        <div class="node-ring completed"></div>
        <div class="node-icon">⚙️</div>
        <div class="node-label">Kubernetes</div>
        <div class="node-progress">100%</div>
        <div class="node-xp">+300 XP</div>
      </div>
      
      <div class="skill-node infrastructure unlocked" style="top: 270px; left: 280px;" data-skill="helm">
        <div class="node-ring completed"></div>
        <div class="node-icon">🗺️</div>
        <div class="node-label">Helm Charts</div>
        <div class="node-progress">100%</div>
        <div class="node-xp">+250 XP</div>
      </div>
      
      <div class="skill-node infrastructure current" style="top: 170px; left: 230px;" data-skill="monitoring">
        <div class="node-ring in-progress"></div>
        <div class="node-icon">📈</div>
        <div class="node-label">Observability</div>
        <div class="node-progress">65%</div>
        <div class="node-xp">+350 XP</div>
        <div class="current-indicator">🎯 In Progress</div>
      </div>
      
      <div class="skill-node infrastructure locked" style="top: 70px; left: 180px;" data-skill="service-mesh">
        <div class="node-ring locked"></div>
        <div class="node-icon">🔒</div>
        <div class="node-label">Service Mesh</div>
        <div class="node-requirements">
          <div class="req-item">Observability mastery required</div>
        </div>
        <div class="node-xp">+400 XP</div>
      </div>
      
      <!-- Development Branch -->
      <div class="skill-node development unlocked" style="top: 470px; left: 580px;" data-skill="apis">
        <div class="node-ring completed"></div>
        <div class="node-icon">🔌</div>
        <div class="node-label">API Design</div>
        <div class="node-progress">100%</div>
        <div class="node-xp">+250 XP</div>
      </div>
      
      <div class="skill-node development partial" style="top: 320px; left: 630px;" data-skill="microservices">
        <div class="node-ring in-progress"></div>
        <div class="node-icon">🧩</div>
        <div class="node-label">Microservices</div>
        <div class="node-progress">40%</div>
        <div class="node-xp">+300 XP</div>
      </div>
      
      <div class="skill-node development locked" style="top: 170px; left: 680px;" data-skill="testing">
        <div class="node-ring locked"></div>
        <div class="node-icon">🧪</div>
        <div class="node-label">Testing Excellence</div>
        <div class="node-requirements">
          <div class="req-item">Microservices completion required</div>
        </div>
        <div class="node-xp">+350 XP</div>
      </div>
      
      <!-- AI/ML Branch -->
      <div class="skill-node aiml unlocked" style="top: 470px; left: 880px;" data-skill="vector-db">
        <div class="node-ring completed"></div>
        <div class="node-icon">🗄</div>
        <div class="node-label">Vector Database</div>
        <div class="node-progress">100%</div>
        <div class="node-xp">+300 XP</div>
      </div>
      
      <div class="skill-node aiml locked" style="top: 320px; left: 930px;" data-skill="inference">
        <div class="node-ring locked"></div>
        <div class="node-icon">🚀</div>
        <div class="node-label">Model Inference</div>
        <div class="node-requirements">
          <div class="req-item">Vector DB + API Design required</div>
        </div>
        <div class="node-xp">+400 XP</div>
      </div>
      
      <div class="skill-node aiml locked" style="top: 170px; left: 980px;" data-skill="training">
        <div class="node-ring locked"></div>
        <div class="node-icon">🧠</div>
        <div class="node-label">Model Training</div>
        <div class="node-requirements">
          <div class="req-item">Model Inference mastery required</div>
        </div>
        <div class="node-xp">+450 XP</div>
      </div>
      
      <!-- Master Node (Ultimate Goal) -->
      <div class="skill-node master locked" style="top: 20px; left: 580px;" data-skill="platform-master">
        <div class="node-ring master-locked"></div>
        <div class="node-icon">👑</div>
        <div class="node-label">Platform Master</div>
        <div class="node-requirements">
          <div class="req-item">All specializations required</div>
          <div class="req-item">10,000+ total XP</div>
          <div class="req-item">Community contributions</div>
        </div>
        <div class="node-xp">+1000 XP</div>
        <div class="master-glow"></div>
      </div>
    </div>
  </div>
  
  <!-- Skill Tree Legend -->
  <div class="skill-tree-legend">
    <h3>Skill Tree Legend</h3>
    <div class="legend-items">
      <div class="legend-item">
        <div class="legend-node completed"></div>
        <span>Mastered (100% complete)</span>
      </div>
      <div class="legend-item">
        <div class="legend-node in-progress"></div>
        <span>In Progress (learning active)</span>
      </div>
      <div class="legend-item">
        <div class="legend-node available"></div>
        <span>Available (prerequisites met)</span>
      </div>
      <div class="legend-item">
        <div class="legend-node locked"></div>
        <span>Locked (prerequisites needed)</span>
      </div>
    </div>
  </div>
</div>
```

### 🔍 Interactive Node Details

#### Skill Node Popup Interface
```html
<!-- Skill Node Detail Popup -->
<div class="skill-popup" id="popup-observability" data-skill="observability">
  <div class="popup-backdrop"></div>
  <div class="popup-content">
    <div class="popup-header">
      <div class="skill-icon-large">📈</div>
      <div class="skill-title">
        <h2>Observability Mastery</h2>
        <div class="skill-category infrastructure">Infrastructure Specialization</div>
      </div>
      <button class="popup-close">×</button>
    </div>
    
    <div class="popup-body">
      <!-- Progress Section -->
      <div class="skill-progress-section">
        <div class="progress-header">
          <h3>Your Progress</h3>
          <div class="progress-stats">65% Complete</div>
        </div>
        
        <div class="progress-visualization">
          <div class="circular-progress" data-progress="65">
            <svg class="progress-ring" width="120" height="120">
              <circle class="progress-ring-circle" 
                      stroke="#e6e6e6" 
                      stroke-width="8" 
                      fill="transparent" 
                      r="52" 
                      cx="60" 
                      cy="60"/>
              <circle class="progress-ring-circle progress" 
                      stroke="#00d4aa" 
                      stroke-width="8" 
                      fill="transparent" 
                      r="52" 
                      cx="60" 
                      cy="60"
                      style="stroke-dasharray: 326.726; stroke-dashoffset: 114.354;"/>
            </svg>
            <div class="progress-text">
              <div class="progress-number">65%</div>
              <div class="progress-label">Complete</div>
            </div>
          </div>
          
          <div class="progress-breakdown">
            <h4>Skill Components</h4>
            <div class="component-list">
              <div class="component-item completed">
                <span class="component-status">✓</span>
                <span class="component-name">Prometheus Setup</span>
                <span class="component-xp">+75 XP</span>
              </div>
              
              <div class="component-item completed">
                <span class="component-status">✓</span>
                <span class="component-name">Grafana Dashboards</span>
                <span class="component-xp">+100 XP</span>
              </div>
              
              <div class="component-item current">
                <span class="component-status">🎯</span>
                <span class="component-name">Distributed Tracing</span>
                <span class="component-progress">60% done</span>
                <span class="component-xp">+125 XP</span>
              </div>
              
              <div class="component-item pending">
                <span class="component-status">○</span>
                <span class="component-name">Alert Management</span>
                <span class="component-xp">+50 XP</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Learning Resources -->
      <div class="skill-resources">
        <h3>Learning Resources</h3>
        <div class="resource-grid">
          <div class="resource-item">
            <div class="resource-type quest">Quest</div>
            <div class="resource-content">
              <h4>Observability Mastery Quest</h4>
              <p>Hands-on implementation of monitoring stack</p>
              <div class="resource-meta">
                <span class="resource-duration">~4 hours</span>
                <span class="resource-xp">+350 XP</span>
              </div>
            </div>
            <button class="resource-action">🚀 Start Quest</button>
          </div>
          
          <div class="resource-item">
            <div class="resource-type docs">Documentation</div>
            <div class="resource-content">
              <h4>Monitoring Architecture Guide</h4>
              <p>Comprehensive observability patterns</p>
              <div class="resource-meta">
                <span class="resource-duration">~45 min read</span>
                <span class="resource-xp">+25 XP</span>
              </div>
            </div>
            <button class="resource-action">📚 Read</button>
          </div>
          
          <div class="resource-item">
            <div class="resource-type video">Tutorial</div>
            <div class="resource-content">
              <h4>Grafana Dashboard Tutorial</h4>
              <p>Building effective monitoring dashboards</p>
              <div class="resource-meta">
                <span class="resource-duration">~30 min</span>
                <span class="resource-xp">+40 XP</span>
              </div>
            </div>
            <button class="resource-action">▶️ Watch</button>
          </div>
        </div>
      </div>
      
      <!-- Prerequisites & Dependencies -->
      <div class="skill-dependencies">
        <div class="dependencies-section">
          <h3>Prerequisites</h3>
          <div class="prereq-list">
            <div class="prereq-item completed">
              <span class="prereq-status">✓</span>
              <span class="prereq-name">Docker Mastery</span>
              <span class="prereq-note">Completed 2 weeks ago</span>
            </div>
            
            <div class="prereq-item completed">
              <span class="prereq-status">✓</span>
              <span class="prereq-name">Kubernetes Basics</span>
              <span class="prereq-note">Strong foundation</span>
            </div>
          </div>
        </div>
        
        <div class="unlocks-section">
          <h3>This Unlocks</h3>
          <div class="unlock-list">
            <div class="unlock-item">
              <span class="unlock-icon">🔒→🔓</span>
              <span class="unlock-name">Service Mesh Mastery</span>
              <span class="unlock-xp">+400 XP potential</span>
            </div>
            
            <div class="unlock-item">
              <span class="unlock-icon">🏆</span>
              <span class="unlock-name">Observability Expert Badge</span>
              <span class="unlock-xp">+200 XP bonus</span>
            </div>
            
            <div class="unlock-item">
              <span class="unlock-icon">🎯</span>
              <span class="unlock-name">Infrastructure Specialist Path</span>
              <span class="unlock-note">Career advancement</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="popup-footer">
      <div class="action-buttons">
        <button class="btn-primary">🚀 Continue Learning</button>
        <button class="btn-secondary">📋 View Full Quest</button>
        <button class="btn-tertiary">🔗 Share Progress</button>
      </div>
    </div>
  </div>
</div>
```

### 🌊 Animated Path Visualization

#### Recommended Learning Path Highlighter
```html
<!-- Recommended Path Overlay -->
<div class="recommended-path-overlay">
  <div class="path-header">
    <h3>🎯 Your Optimal Learning Path</h3>
    <div class="path-stats">
      <span>Estimated completion: 6-8 weeks</span>
      <span>•</span>
      <span>Total XP: 1,250 XP</span>
      <span>•</span>
      <span>3 major achievements</span>
    </div>
  </div>
  
  <div class="path-visualization">
    <!-- Animated Path Lines -->
    <svg class="path-animation" viewBox="0 0 1200 800">
      <defs>
        <linearGradient id="recommendedGradient" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" style="stop-color:#ffd700;stop-opacity:1" />
          <stop offset="100%" style="stop-color:#ff6b35;stop-opacity:1" />
        </linearGradient>
        
        <filter id="glow">
          <feGaussianBlur stdDeviation="4" result="coloredBlur"/>
          <feMerge> 
            <feMergeNode in="coloredBlur"/>
            <feMergeNode in="SourceGraphic"/>
          </feMerge>
        </filter>
      </defs>
      
      <!-- Recommended Path -->
      <path class="recommended-path animated" 
            d="M 600 700 L 300 500 L 300 300 L 250 200" 
            stroke="url(#recommendedGradient)" 
            stroke-width="6" 
            fill="none" 
            filter="url(#glow)"
            stroke-dasharray="20,5"
            opacity="0.8">
        <animate attributeName="stroke-dashoffset" 
                 values="0;-25;0" 
                 dur="2s" 
                 repeatCount="indefinite"/>
      </path>
    </svg>
    
    <!-- Path Step Indicators -->
    <div class="path-steps">
      <div class="path-step completed" style="top: 670px; left: 580px;">
        <div class="step-number">1</div>
        <div class="step-popup">
          <div class="step-title">Foundation Complete</div>
          <div class="step-desc">Great start! Platform basics mastered.</div>
        </div>
      </div>
      
      <div class="path-step completed" style="top: 470px; left: 280px;">
        <div class="step-number">2</div>
        <div class="step-popup">
          <div class="step-title">Docker Mastery</div>
          <div class="step-desc">Containerization skills acquired.</div>
        </div>
      </div>
      
      <div class="path-step completed" style="top: 270px; left: 280px;">
        <div class="step-number">3</div>
        <div class="step-popup">
          <div class="step-title">Helm Charts</div>
          <div class="step-desc">Package management mastered.</div>
        </div>
      </div>
      
      <div class="path-step current" style="top: 170px; left: 230px;">
        <div class="step-number">4</div>
        <div class="step-current-indicator">🎯</div>
        <div class="step-popup">
          <div class="step-title">Next: Observability</div>
          <div class="step-desc">65% complete - finish this for optimal progression</div>
          <div class="step-time">Est: 2-3 hours remaining</div>
          <button class="step-action">🚀 Continue</button>
        </div>
      </div>
      
      <div class="path-step future" style="top: 70px; left: 180px;">
        <div class="step-number">5</div>
        <div class="step-popup">
          <div class="step-title">Future: Service Mesh</div>
          <div class="step-desc">Advanced networking and security</div>
          <div class="step-unlock">Unlocks after Observability</div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="path-timeline">
    <h4>Projected Timeline</h4>
    <div class="timeline-bar">
      <div class="timeline-segment completed" style="width: 40%;">
        <span class="segment-label">Weeks 1-2: Foundation & Docker</span>
      </div>
      <div class="timeline-segment current" style="width: 30%;">
        <span class="segment-label">Week 3: Observability (current)</span>
      </div>
      <div class="timeline-segment future" style="width: 30%;">
        <span class="segment-label">Weeks 4-6: Advanced Topics</span>
      </div>
    </div>
  </div>
</div>
```

### 📊 Skill Analytics Dashboard

#### Personal Skill Analytics
```html
<!-- Skill Analytics Panel -->
<div class="skill-analytics">
  <div class="analytics-header">
    <h3>📊 Your Skill Development Analytics</h3>
    <div class="analytics-timeframe">
      <select class="timeframe-selector">
        <option>Last 30 days</option>
        <option>Last 90 days</option>
        <option>All time</option>
      </select>
    </div>
  </div>
  
  <div class="analytics-grid">
    <!-- Skill Velocity Chart -->
    <div class="analytics-card">
      <div class="card-header">
        <h4>Learning Velocity</h4>
        <div class="velocity-trend positive">↗️ +23% this month</div>
      </div>
      
      <div class="velocity-chart">
        <canvas id="skill-velocity" width="300" height="150"></canvas>
      </div>
      
      <div class="velocity-insights">
        <div class="insight-item">
          <span class="insight-label">Peak learning day:</span>
          <span class="insight-value">Tuesday (+45% above average)</span>
        </div>
        <div class="insight-item">
          <span class="insight-label">Preferred learning time:</span>
          <span class="insight-value">9-11 AM (highest completion rate)</span>
        </div>
      </div>
    </div>
    
    <!-- Skill Distribution Radar -->
    <div class="analytics-card">
      <div class="card-header">
        <h4>Skill Balance</h4>
        <div class="balance-score">Specialization Score: 8.2/10</div>
      </div>
      
      <div class="skill-radar">
        <canvas id="skill-radar-chart" width="250" height="250"></canvas>
      </div>
      
      <div class="radar-legend">
        <div class="legend-item">
          <div class="legend-color infra"></div>
          <span>Infrastructure (Strong)</span>
        </div>
        <div class="legend-item">
          <div class="legend-color dev"></div>
          <span>Development (Growing)</span>
        </div>
        <div class="legend-item">
          <div class="legend-color ai"></div>
          <span>AI/ML (Emerging)</span>
        </div>
        <div class="legend-item">
          <div class="legend-color ops"></div>
          <span>Operations (Moderate)</span>
        </div>
      </div>
    </div>
    
    <!-- Completion Patterns -->
    <div class="analytics-card">
      <div class="card-header">
        <h4>Learning Patterns</h4>
      </div>
      
      <div class="pattern-analysis">
        <div class="pattern-item">
          <div class="pattern-icon">🎯</div>
          <div class="pattern-content">
            <h5>Focus Style</h5>
            <div class="pattern-desc">Deep specialization - you prefer mastering one area before moving to the next</div>
            <div class="pattern-strength">Strength: High retention and expertise depth</div>
          </div>
        </div>
        
        <div class="pattern-item">
          <div class="pattern-icon">⏱️</div>
          <div class="pattern-content">
            <h5>Pacing Preference</h5>
            <div class="pattern-desc">Steady progress - consistent daily engagement with moderate complexity</div>
            <div class="pattern-rec">Recommendation: Maintain 60-90 min daily sessions</div>
          </div>
        </div>
        
        <div class="pattern-item">
          <div class="pattern-icon">🏆</div>
          <div class="pattern-content">
            <h5>Achievement Motivation</h5>
            <div class="pattern-desc">Goal-oriented - strong response to clear milestones and rewards</div>
            <div class="pattern-insight">Your completion rate is 40% higher with defined targets</div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Skill Recommendations -->
    <div class="analytics-card recommendations">
      <div class="card-header">
        <h4>AI-Powered Recommendations</h4>
        <div class="ai-confidence">Confidence: 94%</div>
      </div>
      
      <div class="rec-list">
        <div class="rec-item priority">
          <div class="rec-badge high">High Priority</div>
          <div class="rec-content">
            <h5>Complete Observability Mastery</h5>
            <div class="rec-reasoning">You're 65% done and it unlocks 3 high-value skills</div>
            <div class="rec-impact">Impact: +750 XP, Service Mesh unlock, Infrastructure specialization progress</div>
          </div>
          <button class="rec-action">🚀 Focus Here</button>
        </div>
        
        <div class="rec-item strategic">
          <div class="rec-badge medium">Strategic</div>
          <div class="rec-content">
            <h5>Start API Design Learning</h5>
            <div class="rec-reasoning">Complements your infrastructure skills and opens development path</div>
            <div class="rec-timeline">Optimal timing: After completing current observability work</div>
          </div>
          <button class="rec-action">📋 Plan Ahead</button>
        </div>
        
        <div class="rec-item exploratory">
          <div class="rec-badge low">Exploratory</div>
          <div class="rec-content">
            <h5>Explore AI/ML Fundamentals</h5>
            <div class="rec-reasoning">Growing field with high career potential</div>
            <div class="rec-prereq">Prerequisites: Vector Database knowledge (you have this!)</div>
          </div>
          <button class="rec-action">🔍 Explore</button>
        </div>
      </div>
    </div>
  </div>
</div>
```

### 🏅 Skill Achievements Integration

#### Skill-Based Achievement Tracker
```html
<!-- Skill Achievement Integration -->
<div class="skill-achievements-panel">
  <div class="panel-header">
    <h3>🏆 Skill-Based Achievements</h3>
    <div class="achievement-progress">
      <span>12 of 28 skill achievements unlocked</span>
    </div>
  </div>
  
  <div class="skill-achievement-categories">
    <!-- Mastery Achievements -->
    <div class="achievement-category">
      <h4>Skill Mastery Badges</h4>
      <div class="mastery-grid">
        <div class="mastery-badge unlocked">
          <div class="badge-icon">🐳</div>
          <div class="badge-name">Docker Master</div>
          <div class="badge-date">Earned 2 weeks ago</div>
        </div>
        
        <div class="mastery-badge unlocked">
          <div class="badge-icon">⚙️</div>
          <div class="badge-name">Kubernetes Expert</div>
          <div class="badge-date">Earned 1 week ago</div>
        </div>
        
        <div class="mastery-badge in-progress">
          <div class="badge-icon">📈</div>
          <div class="badge-name">Observability Pro</div>
          <div class="badge-progress">65% complete</div>
          <div class="badge-requirement">Complete distributed tracing</div>
        </div>
        
        <div class="mastery-badge locked">
          <div class="badge-icon locked">🔒</div>
          <div class="badge-name">Service Mesh Guru</div>
          <div class="badge-requirement">Requires Observability mastery</div>
        </div>
      </div>
    </div>
    
    <!-- Progression Achievements -->
    <div class="achievement-category">
      <h4>Learning Progression</h4>
      <div class="progression-achievements">
        <div class="prog-achievement unlocked">
          <div class="prog-icon">🌱</div>
          <div class="prog-info">
            <div class="prog-name">First Branch Complete</div>
            <div class="prog-desc">Completed your first skill branch</div>
          </div>
          <div class="prog-xp">+200 XP</div>
        </div>
        
        <div class="prog-achievement unlocked">
          <div class="prog-icon">🔗</div>
          <div class="prog-info">
            <div class="prog-name">Skill Chain Builder</div>
            <div class="prog-desc">Completed 5 connected skills</div>
          </div>
          <div class="prog-xp">+150 XP</div>
        </div>
        
        <div class="prog-achievement near-unlock">
          <div class="prog-icon">🎯</div>
          <div class="prog-info">
            <div class="prog-name">Specialization Focus</div>
            <div class="prog-desc">Complete 80% of a specialization branch</div>
            <div class="prog-progress">72% complete (close!)</div>
          </div>
          <div class="prog-xp">+300 XP</div>
        </div>
      </div>
    </div>
    
    <!-- Speed Achievements -->
    <div class="achievement-category">
      <h4>Learning Speed Records</h4>
      <div class="speed-records">
        <div class="speed-record">
          <div class="record-icon">⚡</div>
          <div class="record-info">
            <div class="record-name">Docker Speed Run</div>
            <div class="record-time">Completed in 4.2 hours</div>
            <div class="record-rank">Top 15% completion time</div>
          </div>
          <div class="record-badge">🥈 Silver</div>
        </div>
        
        <div class="speed-opportunity">
          <div class="opp-icon">🏃</div>
          <div class="opp-info">
            <div class="opp-name">Observability Sprint</div>
            <div class="opp-challenge">Complete remaining 35% in under 3 hours</div>
            <div class="opp-reward">Unlock Speed Demon badge (+150 XP)</div>
          </div>
          <button class="opp-accept">🚀 Accept Challenge</button>
        </div>
      </div>
    </div>
  </div>
</div>
```

---

## 📱 Mobile Skill Tree Experience

### 📲 Touch-Optimized Tree Navigation

```html
<!-- Mobile Skill Tree Interface -->
<div class="mobile-skill-tree">
  <div class="mobile-tree-header">
    <h2>🌳 Skill Tree</h2>
    <div class="mobile-progress">
      <div class="progress-circle small" data-progress="36">
        <span>36%</span>
      </div>
      <div class="progress-text">
        <div>15/42 skills</div>
        <div>unlocked</div>
      </div>
    </div>
  </div>
  
  <div class="mobile-tree-nav">
    <div class="nav-dots">
      <button class="nav-dot active" data-branch="infrastructure">🏗️</button>
      <button class="nav-dot" data-branch="development">💻</button>
      <button class="nav-dot" data-branch="aiml">🧠</button>
      <button class="nav-dot" data-branch="operations">⚙️</button>
    </div>
  </div>
  
  <!-- Swipeable Skill Branch -->
  <div class="mobile-tree-container">
    <div class="skill-branch-mobile" data-branch="infrastructure">
      <div class="branch-title">
        <h3>🏗️ Infrastructure Path</h3>
        <div class="branch-progress">4/6 complete</div>
      </div>
      
      <div class="mobile-skill-flow">
        <div class="skill-node-mobile unlocked" data-skill="foundation">
          <div class="node-icon completed">🌱</div>
          <div class="node-info">
            <div class="node-name">Foundation</div>
            <div class="node-status">Mastered</div>
          </div>
          <div class="node-xp">+150 XP</div>
        </div>
        
        <div class="skill-connector completed"></div>
        
        <div class="skill-node-mobile unlocked" data-skill="docker">
          <div class="node-icon completed">🐳</div>
          <div class="node-info">
            <div class="node-name">Docker</div>
            <div class="node-status">Mastered</div>
          </div>
          <div class="node-xp">+200 XP</div>
        </div>
        
        <div class="skill-connector completed"></div>
        
        <div class="skill-node-mobile unlocked" data-skill="kubernetes">
          <div class="node-icon completed">⚙️</div>
          <div class="node-info">
            <div class="node-name">Kubernetes</div>
            <div class="node-status">Mastered</div>
          </div>
          <div class="node-xp">+300 XP</div>
        </div>
        
        <div class="skill-connector completed"></div>
        
        <div class="skill-node-mobile current" data-skill="observability">
          <div class="node-icon in-progress">📈</div>
          <div class="node-info">
            <div class="node-name">Observability</div>
            <div class="node-progress">65% complete</div>
          </div>
          <div class="node-time">~2h left</div>
          <button class="continue-btn">▶️ Continue</button>
        </div>
        
        <div class="skill-connector in-progress"></div>
        
        <div class="skill-node-mobile locked" data-skill="service-mesh">
          <div class="node-icon locked">🔒</div>
          <div class="node-info">
            <div class="node-name">Service Mesh</div>
            <div class="node-requirement">Complete Observability</div>
          </div>
          <div class="node-xp">+400 XP</div>
        </div>
        
        <div class="skill-connector locked"></div>
        
        <div class="skill-node-mobile locked specialization" data-skill="infra-specialist">
          <div class="node-icon specialization">🏆</div>
          <div class="node-info">
            <div class="node-name">Infrastructure Specialist</div>
            <div class="node-requirement">Complete all above + 2 more</div>
          </div>
          <div class="node-xp">+1000 XP</div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="mobile-tree-actions">
    <button class="action-btn primary">🚀 Continue Current</button>
    <button class="action-btn secondary">📊 View Analytics</button>
  </div>
</div>
```

---

**🌳 Interactive Skill Tree complete! This comprehensive visualization system provides:**

- **Visual learning paths** with clear progression and dependencies
- **Interactive node details** with comprehensive skill information
- **Animated recommendations** highlighting optimal learning paths
- **Personal analytics** showing learning patterns and velocity
- **Achievement integration** connecting skills to gamification rewards
- **Mobile-optimized experience** with touch-friendly navigation
- **Real-time progress tracking** with completion percentages and time estimates

*The skill tree transforms abstract learning concepts into an engaging, visual journey that clearly shows progress, dependencies, and future opportunities while maintaining motivation through gamified elements.*