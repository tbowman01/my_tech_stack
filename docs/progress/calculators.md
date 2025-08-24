# Progress Calculators 🧮

Interactive calculators to track your XP, level progression, and skill development.

## 🎯 XP Calculator

Use these formulas to calculate your experience points:

### Base XP Values
| Task Type | Difficulty | Base XP | Time Bonus |
|-----------|------------|---------|------------|
| Documentation | Easy | 10 | +5 if <30min |
| Code Review | Easy | 15 | +5 if <1hr |
| Bug Fix | Medium | 25 | +10 if <2hr |
| Feature | Medium | 50 | +15 if <4hr |
| Architecture | Hard | 100 | +25 if <8hr |
| System Design | Hard | 150 | +50 if <1day |

### Quality Multipliers
| Quality Level | Multiplier | Requirements |
|---------------|------------|--------------|
| Basic | 1.0x | Meets requirements |
| Good | 1.2x | Exceeds expectations |
| Excellent | 1.5x | Exceptional quality |
| Perfect | 2.0x | Industry best practice |

### Bonus Multipliers
| Bonus Type | Multiplier | Condition |
|------------|------------|-----------|
| First Attempt | 1.5x | No revisions needed |
| Documentation | 1.2x | Includes good docs |
| Tests Included | 1.3x | Comprehensive tests |
| Innovation | 2.0x | Creative/novel solution |
| Teaching | 1.5x | Helps others learn |
| Open Source | 1.4x | Public contribution |

### XP Calculation Formula
```
Final XP = (Base XP + Time Bonus) × Quality Multiplier × Bonus Multipliers × Streak Multiplier

Streak Multiplier:
- Days 1-3: 1.0x
- Days 4-7: 1.1x
- Days 8-15: 1.2x
- Days 16-30: 1.3x
- Days 31+: 1.5x
```

### Example Calculation
```
Task: Implement user authentication system
Base XP: 100 (Hard feature)
Time Bonus: 25 (completed in 6 hours)
Quality: 1.5x (Excellent - includes security best practices)
Bonuses: 1.3x (comprehensive tests) × 1.2x (good documentation) = 1.56x
Streak: 1.2x (12-day streak)

Final XP = (100 + 25) × 1.5 × 1.56 × 1.2 = 351 XP
```

## 📊 Level Progression Calculator

### Level Requirements Table
| Level Range | Title | XP per Level | Total XP | Skill Points |
|-------------|-------|--------------|----------|--------------|
| 1-5 | Novice | 20 | 0-100 | 1-3 |
| 6-10 | Apprentice | 50 | 100-350 | 3-5 |
| 11-15 | Journeyman | 100 | 350-850 | 6-8 |
| 16-20 | Expert | 200 | 850-1650 | 8-10 |
| 21-25 | Master | 400 | 1650-3650 | 11-13 |
| 26-30 | Grandmaster | 800 | 3650-7650 | 13-15 |
| 31+ | Legend | 1600 | 7650+ | 16+ |

### Current Level Calculator
```
Current XP: _____ 

Level Calculation:
If XP ≤ 100: Level = (XP ÷ 20) + 1
If XP ≤ 350: Level = ((XP - 100) ÷ 50) + 6
If XP ≤ 850: Level = ((XP - 350) ÷ 100) + 11
If XP ≤ 1650: Level = ((XP - 850) ÷ 200) + 16
If XP ≤ 3650: Level = ((XP - 1650) ÷ 400) + 21
If XP ≤ 7650: Level = ((XP - 3650) ÷ 800) + 26
If XP > 7650: Level = ((XP - 7650) ÷ 1600) + 31

Your Level: _____
Your Title: _____
XP to Next Level: _____
```

## ⭐ Skill Points Calculator

### Skill Point Allocation
```
Total Skill Points Available: Level ÷ 2 (rounded up)

Skill Categories & Maximums:
┌─────────────────┬─────────┬─────────────────────────────┐
│ Skill Category  │ Max Pts │ Benefits                    │
├─────────────────┼─────────┼─────────────────────────────┤
│ 🏗️ Architecture  │   10    │ +5% XP for design tasks     │
│ 🔧 DevOps        │   10    │ +5% XP for deployment tasks │
│ 🧪 Testing       │    8    │ +10% XP for testing tasks   │
│ 📚 Documentation │    6    │ +15% XP for doc tasks       │
│ 🔒 Security      │    8    │ +10% XP for security tasks  │
│ ⚡ Performance   │    8    │ +10% XP for optimization    │
└─────────────────┴─────────┴─────────────────────────────┘

Current Allocation:
Architecture:  ___/10 points
DevOps:        ___/10 points
Testing:       ___/8 points
Documentation: ___/6 points
Security:      ___/8 points
Performance:   ___/8 points

Total Used: ___/50 points
```

## 🏆 Achievement Progress Calculator

### Achievement Categories
| Category | Bronze (10-25 XP) | Silver (50-100 XP) | Gold (150-300 XP) | Legendary (500+ XP) |
|----------|-------------------|---------------------|-------------------|---------------------|
| Coding | 10 achievements | 8 achievements | 5 achievements | 2 achievements |
| Testing | 6 achievements | 5 achievements | 3 achievements | 1 achievement |
| DevOps | 8 achievements | 6 achievements | 4 achievements | 2 achievements |
| Community | 12 achievements | 7 achievements | 3 achievements | 1 achievement |
| Learning | 15 achievements | 10 achievements | 5 achievements | 2 achievements |

### Achievement Completion Rate
```
Total Achievements Available: 100
Your Achievements: _____

Completion Rate: (Your Achievements ÷ 100) × 100 = _____%

Achievement XP Earned:
Bronze: _____ × avg(17.5 XP) = _____ XP
Silver: _____ × avg(75 XP) = _____ XP
Gold: _____ × avg(225 XP) = _____ XP
Legendary: _____ × avg(750 XP) = _____ XP

Total Achievement XP: _____ XP
```

## 📈 Streak Calculator

### Streak Multipliers
| Streak Days | Multiplier | Bonus Description |
|-------------|------------|-------------------|
| 1-3 days | 1.0x | Getting Started |
| 4-7 days | 1.1x | Building Momentum |
| 8-15 days | 1.2x | Strong Habit |
| 16-30 days | 1.3x | Dedicated Developer |
| 31-60 days | 1.4x | Committed Professional |
| 61-100 days | 1.5x | Unstoppable Force |
| 100+ days | 2.0x | Legendary Dedication |

### Streak Impact Calculator
```
Current Streak: _____ days
Current Multiplier: _____x

Weekly XP without streak: _____ XP
Weekly XP with streak: _____ XP
Weekly Bonus XP: _____ XP

If you maintain this streak for 30 days:
Total Bonus XP: _____ XP
Equivalent Level Gain: _____ levels
```

## 🎯 Goal Setting Calculator

### SMART Goal Template
```
Goal: _________________________________

Specific: What exactly will you accomplish?
_____________________________________

Measurable: How will you measure success?
Target XP: _____ XP
Target Level: _____
Target Achievements: _____

Achievable: Is this realistic given your schedule?
Time available per day: _____ hours
Current skill level: _____

Relevant: How does this align with your career goals?
_____________________________________

Time-bound: When will you complete this?
Target date: _____
Days available: _____
Required daily XP: _____ XP/day
```

### Progress Tracking Table
| Week | Target XP | Actual XP | Variance | Cumulative | On Track? |
|------|-----------|-----------|----------|------------|-----------|
| 1 | _____ | _____ | _____ | _____ | ☐ |
| 2 | _____ | _____ | _____ | _____ | ☐ |
| 3 | _____ | _____ | _____ | _____ | ☐ |
| 4 | _____ | _____ | _____ | _____ | ☐ |

## 📊 Performance Analytics

### Productivity Metrics
```
Average Daily XP: _____ XP
Best Day XP: _____ XP
Longest Streak: _____ days
Current Streak: _____ days

Most Productive Day: _____
Most Productive Time: _____
Favorite Task Type: _____
Strongest Skill Area: _____

Weekly Trend:
Week 1: _____ XP
Week 2: _____ XP (+/- _____)
Week 3: _____ XP (+/- _____)
Week 4: _____ XP (+/- _____)

Growth Rate: ____% per week
```

## 🏅 Leaderboard Position

### Community Rankings
```
Your Stats:
Total XP: _____ XP
Level: _____ (_____)
Achievements: _____
Streak: _____ days

Estimated Position:
Top 10%: _____ XP required
Top 5%: _____ XP required  
Top 1%: _____ XP required

XP needed for next percentile: _____ XP
Estimated time to reach: _____ days
```

---

*Use these calculators to optimize your learning path and maximize your progress! Remember, consistency beats intensity. 📈*