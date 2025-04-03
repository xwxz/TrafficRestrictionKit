# 北京尾号限行规则解析插件
提供2025年限行规则

## 使用指南
1. 导入TrafficRestrictionKit
2. let manager = TrafficRestrictionManager()
3. 获取今日限行： `let restrictions = manager.getNextWeekRestrictions(currentDate: startDate)`

