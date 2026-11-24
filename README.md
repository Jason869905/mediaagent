# MediaAgent

MediaAgent 是一个面向小红书、抖音、微博等新媒体平台的一站式 AI Agent 运营平台。通过多个智能 Agent 协作，帮助运营者完成从热点洞察、内容创作、发布管理到数据分析的全流程工作，让内容运营更高效、更智能。

## ✨ 核心功能

### 🔥 热点笔记智能分析
- 自动抓取并分析平台热门笔记，识别爆款内容模式
- 拆解笔记的标题、封面、正文结构、话题标签等关键要素
- 输出热点趋势报告，帮助运营者快速把握平台风向
- 支持按领域、关键词、时间维度定制化监控

### ✍️ 智能内容生成
- 基于热点分析和账号定位，自动生成笔记文案
- 支持多种内容风格：种草文、测评文、教程文、日常分享等
- 智能推荐标题、话题标签和封面文案
- 生成内容支持人工二次编辑和润色

### 📤 发布助手（人工审阅）
- 统一管理多平台发布任务，支持定时发布
- **所有内容发布前必须经过人工审阅确认**，确保内容质量和合规性
- 提供发布预览，模拟最终展示效果
- 发布状态实时追踪，支持一键撤回（平台支持的情况下）

### 📊 数据分析
- 多维度数据看板：曝光、互动、涨粉、转化等核心指标
- 自动生成日报 / 周报 / 月报，洞察数据变化趋势
- 爆款笔记归因分析，总结可复用的成功经验
- 支持跨账号、跨平台数据对比

### 💡 运营优化建议
- 基于数据分析结果，自动生成运营优化策略
- 提供选题方向、发布时间、内容形式等具体建议
- 智能诊断账号问题，给出改进方案
- 持续学习账号历史表现，建议越来越精准

## 🏗️ 平台架构

```
┌─────────────────────────────────────────────────┐
│                   用户界面 (Web)                  │
├─────────────────────────────────────────────────┤
│              Agent 编排与调度层                    │
├──────────┬──────────┬──────────┬────────────────┤
│ 热点分析  │ 内容生成  │ 发布助手  │ 数据分析 Agent  │
│  Agent   │  Agent   │  Agent   │     Agent      │
├──────────┴──────────┴──────────┴────────────────┤
│              LLM 推理与工具调用层                  │
├─────────────────────────────────────────────────┤
│           平台适配层（小红书 / 抖音 / 微博）         │
├─────────────────────────────────────────────────┤
│         数据存储（笔记 / 指标 / 任务 / 日志）       │
└─────────────────────────────────────────────────┘
```

## 🚀 快速开始

### 环境要求

- Python 3.10+
- Node.js 18+（前端）
- Docker & Docker Compose（可选，用于本地部署）

### 安装与启动

```bash
# 克隆仓库
git clone <repository-url>
cd mediaagent

# 安装依赖
pip install -r requirements.txt

# 配置环境变量
cp .env.example .env
# 编辑 .env 文件，填入必要的 API Key 等配置

# 启动服务
python main.py
```

## ⚙️ 配置说明

创建 `.env` 文件并配置以下参数：

```env
# LLM 配置
LLM_API_KEY=your-api-key
LLM_MODEL=gpt-4o

# 小红书平台配置
XHS_COOKIE=your-xhs-cookie

# 数据库配置
DATABASE_URL=sqlite:///./mediaagent.db

# 其他平台配置（按需填写）
# DOUYIN_COOKIE=...
# WEIBO_COOKIE=...
```

## 📖 使用示例

### 1. 分析热点笔记

```python
from mediaagent.agents.trend_agent import TrendAgent

agent = TrendAgent()
report = agent.analyze_trends(
    platform="xiaohongshu",
    category="美妆",
    days=7
)
print(report.summary)
```

### 2. 生成笔记内容

```python
from mediaagent.agents.content_agent import ContentAgent

agent = ContentAgent()
note = agent.generate_note(
    topic="秋冬护肤",
    style="种草文",
    target_audience="18-30岁女性"
)
print(note.title)
print(note.content)
```

### 3. 提交发布任务（需人工审阅）

```python
from mediaagent.agents.publish_agent import PublishAgent

agent = PublishAgent()
task = agent.create_task(
    note_id="note-123",
    platform="xiaohongshu",
    schedule_time="2024-12-01 18:00"
)
# 任务将进入待审阅状态，需在管理后台确认后才会实际发布
print(task.status)  # pending_review
```

## 🔒 安全与合规

- **人工审阅机制**：所有 AI 生成的内容在发布前必须经过人工确认，平台不会自动发布任何内容
- **数据安全**：账号凭证加密存储，敏感信息不会泄露
- **平台合规**：严格遵守各平台的内容规范和 API 使用条款

## 🗺️ Roadmap

- [x] 项目规划与架构设计
- [ ] 热点笔记分析 Agent
- [ ] 内容生成 Agent
- [ ] 发布助手（人工审阅流程）
- [ ] 数据分析看板
- [ ] 运营优化建议引擎
- [ ] 多账号管理
- [ ] 移动端适配

## 🤝 贡献指南

欢迎参与项目共建！请遵循以下流程：

1. Fork 本仓库
2. 创建特性分支：`git checkout -b feature/your-feature`
3. 提交更改：`git commit -m "feat: add your feature"`
4. 推送分支：`git push origin feature/your-feature`
5. 提交 Pull Request

## 📄 License

MIT License

