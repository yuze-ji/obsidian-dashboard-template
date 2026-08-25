```dataviewjs
// ============ 多语言配置 ============
const lang = localStorage.getItem('dashboardLang') || 'cn';
const i18n = {
  cn: {
    noteActivity: '笔记活动',
    projectsBoard: '项目概览',
    taskboard: '任务统计',
    taskDetails: '任务详情',
    today: '今日',
    todo: '待办',
    done: '完成',
    projects: '项目',
    tasks: '任务',
    recentEdited: '最近编辑',
    totalNotes: '总笔记数量',
    totalWords: '总字数',
    totalLinks: '总链接数',
    last365days: '最近 365 天',
    noTodayTasks: '暂无今日任务',
    noTodoTasks: '没有待办任务',
    noDoneTasks: '还没有完成的任务'
  },
  en: {
    noteActivity: 'Note Activity',
    projectsBoard: 'Projects Board',
    taskboard: 'Taskboard',
    taskDetails: 'Task Details',
    today: 'Today',
    todo: 'Todo',
    done: 'Done',
    projects: 'Projects',
    tasks: 'Tasks',
    recentEdited: 'Recently Edited',
    totalNotes: 'Total Notes',
    totalWords: 'Total Words',
    totalLinks: 'Total Links',
    last365days: 'Last 365 Days',
    noTodayTasks: 'No tasks today',
    noTodoTasks: 'No tasks',
    noDoneTasks: 'No completed tasks'
  }
};
const t = i18n[lang];

// ============ 颜色和日期配置 ============
const colorScheme = ['#E3E7E5', '#C8AADC', '#F3D98C', '#F0A868', '#E88E8E'];
const weekdayShort = lang === 'cn' ? ['一', '二', '三', '四', '五', '六', '日'] : ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
const weekdayFull = lang === 'cn' ? ['星期一','星期二','星期三','星期四','星期五','星期六','星期日'] : ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
const monthNamesCN = lang === 'cn' ? ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'] : ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

const dateMap = {};
const createdMap = {};
dv.pages().forEach(p => {
    if (p.file.mtime) {
        const d = moment(p.file.mtime.toString()).format('YYYY-MM-DD');
        dateMap[d] = (dateMap[d] || 0) + 1;
    }
    if (p.file.ctime) {
        const cd = moment(p.file.ctime.toString()).format('YYYY-MM-DD');
        if (!createdMap[cd]) createdMap[cd] = [];
        createdMap[cd].push(p.file.name);
    }
});

function levelOf(count) {
    return Math.min(count > 0 ? 1 + Math.floor((count - 1) / 2) : 0, 4);
}

// ============ 顶部导航栏 ============
const navContainer = dv.el("div", "");
const navHtml = `
<style>
.navbar-wrapper {
  background: linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);
  border-bottom: 2px solid rgba(93, 167, 110, 0.4);
  padding: 14px 20px;
  margin-bottom: 20px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 24px;
  flex-wrap: wrap;
  box-shadow: 0 2px 8px rgba(93, 167, 110, 0.08);
  backdrop-filter: blur(10px);
}

@media (prefers-color-scheme: dark) {
  .navbar-wrapper {
    background: linear-gradient(135deg, rgba(130, 190, 160, 0.15) 0%, rgba(65, 140, 90, 0.08) 100%);
    border-bottom-color: rgba(130, 190, 160, 0.5);
    box-shadow: 0 2px 8px rgba(65, 140, 90, 0.12);
  }
}

.navbar-links {
  display: flex;
  gap: 16px;
  align-items: center;
}
.navbar-links a {
  color: var(--interactive-accent);
  text-decoration: none;
  font-weight: 600;
  font-size: 0.95em;
  opacity: 0.8;
  transition: all 0.2s ease;
  padding: 6px 12px;
  border-radius: 6px;
}
.navbar-links a:hover {
  opacity: 1;
  background: rgba(91,141,239,0.1);
  transform: translateY(-1px);
}
.navbar-sep {
  opacity: 0.3;
}
.navbar-lang {
  display: inline-flex;
  gap: 8px;
  padding: 6px 12px;
  background: rgba(91,141,239,0.12);
  border-radius: 8px;
  border: 1px solid rgba(91,141,239,0.25);
}
.navbar-lang span {
  cursor: pointer;
  font-size: 0.85em;
  color: var(--interactive-accent);
  padding: 2px 6px;
  border-radius: 4px;
  transition: all 0.2s;
}
.navbar-lang span:hover {
  background: rgba(91,141,239,0.2);
}
.navbar-lang span.active {
  font-weight: 700;
  background: rgba(91,141,239,0.25);
}
</style>
<div class="navbar-wrapper">
  <div class="navbar-links">
    <a href="javascript:void(0)" data-href="Projects/Project List.md" class="internal-link">📋 ${t.projects}</a>
    <span class="navbar-sep">·</span>
    <a href="javascript:void(0)" data-href="Projects/Todo List.md" class="internal-link">✅ ${t.tasks}</a>
  </div>
  <div class="navbar-lang" id="navbar-lang-switch">
    <span class="lang-opt" data-lang="cn" style="${lang === 'cn' ? 'font-weight:700;' : 'opacity:0.5;'}">中</span>
    <span style="opacity:0.3;">/</span>
    <span class="lang-opt" data-lang="en" style="${lang === 'en' ? 'font-weight:700;' : 'opacity:0.5;'}">En</span>
  </div>
</div>
`;
navContainer.innerHTML = navHtml;

// 语言切换事件
setTimeout(() => {
  document.querySelectorAll('.lang-opt').forEach(btn => {
    btn.onclick = function() {
      localStorage.setItem('dashboardLang', this.getAttribute('data-lang'));
      location.reload();
    };
  });
}, 100);

const container = dv.el("div", "");
let currentView = "year";
const todayStr = moment().format('YYYY-MM-DD');

const style = `
<style>
/* ========== Design System ========== */
:root {
  --primary: #5B8DEF;
  --primary-light: #8FB8D9;
  --success: #5FA860;
  --warning: #F0A868;
  --danger: #E8A0A0;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 12px;
  --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.08);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.12);
  --shadow-lg: 0 12px 24px rgba(0, 0, 0, 0.16);
}

@import url('https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600&display=swap');

/* ========== Card ========== */
.na-card{
  font-family:'Figtree',BlinkMacSystemFont,sans-serif;
  background:linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);
  border-radius:var(--radius-lg);
  padding:24px;
  position:relative;
  box-shadow:0 8px 32px rgba(93, 167, 110, 0.06);
  border:1px solid rgba(154, 208, 180, 0.25);
  transition:all 0.3s ease;
  backdrop-filter: blur(10px);
}

.na-card:hover{
  border-color:rgba(93, 167, 110, 0.5);
  box-shadow:0 12px 40px rgba(93, 167, 110, 0.12);
  background:linear-gradient(135deg, rgba(154, 208, 180, 0.15) 0%, rgba(93, 167, 110, 0.08) 100%);
}

@media (prefers-color-scheme: dark) {
  .na-card{
    background:linear-gradient(135deg, rgba(130, 190, 160, 0.15) 0%, rgba(65, 140, 90, 0.08) 100%);
    box-shadow:0 8px 32px rgba(65, 140, 90, 0.08);
    border-color:rgba(130, 190, 160, 0.3);
  }
  .na-card:hover{
    border-color:rgba(130, 190, 160, 0.6);
    box-shadow:0 12px 40px rgba(65, 140, 90, 0.15);
    background:linear-gradient(135deg, rgba(130, 190, 160, 0.2) 0%, rgba(65, 140, 90, 0.1) 100%);
  }
}

.na-title{
  font-size:1.3em;
  font-weight:700;
  color:var(--interactive-accent);
  margin-bottom:16px;
  letter-spacing:-0.02em;
  text-align:center;
}

.na-divider{
  border-bottom:1px solid var(--background-modifier-border);
  margin-bottom:20px;
}

/* ========== Tabs ========== */
.na-tabs{
  display:flex;
  background:var(--background-secondary);
  border-radius:var(--radius-md);
  padding:4px;
  gap:2px;
}

.na-tab{
  font-size:0.8em;
  padding:8px 16px;
  border-radius:var(--radius-sm);
  cursor:pointer;
  color:#7A8B93;
  user-select:none;
  transition:all 0.2s ease;
  border:none;
  background:transparent;
  font-weight:600;
}

.na-tab:hover{
  color:var(--text-normal);
  background:rgba(91, 141, 239, 0.08);
}

.na-tab.active{
  background:var(--background-primary);
  color:var(--interactive-accent);
  font-weight:700;
  box-shadow:var(--shadow-sm);
}

/* ========== Legend & Badges ========== */
.na-legend{
  display:flex;
  align-items:center;
  gap:6px;
  font-size:0.75em;
  color:#8A9BA3;
  font-weight:600;
}

.na-legend-box{
  width:10px;
  height:10px;
  border-radius:3px;
  transition:transform 0.2s ease;
}

.na-badges{
  display:flex;
  gap:10px;
  margin-top:16px;
  flex-wrap:wrap;
}

.na-badge{
  font-size:0.8em;
  color:var(--text-normal);
  background:var(--background-secondary);
  padding:8px 14px;
  border-radius:20px;
  border:1px solid var(--background-modifier-border);
  font-weight:600;
  transition:all 0.2s ease;
}

.na-badge:hover{
  border-color:var(--interactive-accent);
  background:rgba(91, 141, 239, 0.08);
  color:var(--interactive-accent);
}

/* ---- 年视图：GitHub 风格，一行控制栏 ---- */
.na-year-bar{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:8px;margin-bottom:14px;}
.na-range{font-size:0.8em;color:#8A9BA3;}
.na-scroll{overflow-x:auto;padding-bottom:8px;}
.na-scroll::-webkit-scrollbar{height:5px;}
.na-scroll::-webkit-scrollbar-thumb{background:var(--background-modifier-border);border-radius:3px;}
.na-scroll::-webkit-scrollbar-track{background:transparent;}
.na-months{display:flex;margin-left:22px;margin-bottom:5px;height:14px;position:relative;min-width:max-content;}
.na-month-label{position:absolute;font-size:11px;color:var(--interactive-accent);white-space:nowrap;font-weight:600;letter-spacing:0.5px;}
.na-body{display:flex;gap:3px;align-items:flex-start;min-width:max-content;}
.na-wk-labels{display:flex;flex-direction:column;gap:3px;font-size:9px;color:#8A9BA3;line-height:11px;padding-top:1px;}
.na-wk-label{height:11px;}
.na-grid{display:flex;gap:3px;}
.na-week{display:flex;flex-direction:column;gap:3px;}
.na-pill{width:11px;height:11px;border-radius:3.5px;background:${colorScheme[0]};cursor:pointer;transition:transform 0.1s;}
.na-pill:hover{transform:scale(1.25);}
.na-pill[data-level="1"]{background:${colorScheme[1]};}
.na-pill[data-level="2"]{background:${colorScheme[2]};}
.na-pill[data-level="3"]{background:${colorScheme[3]};}
.na-pill[data-level="4"]{background:${colorScheme[4]};}
.na-pill.today{box-shadow:0 0 0 1.5px #E88E8E;}

/* ---- 月视图：真正的日历网格，图例放网格下方 ---- */
.na-month-top{display:flex;align-items:center;justify-content:space-between;margin-bottom:14px;}
.na-month-title{font-size:0.95em;font-weight:600;color:var(--text-normal);}
.na-cal-weekdays{display:grid;grid-template-columns:repeat(7,minmax(0,1fr));gap:2px;margin-bottom:2px;max-width:280px;margin-left:auto;margin-right:auto;}
.na-cal-wk-label{font-size:9px;color:#8A9BA3;text-align:center;}
.na-cal-grid{display:grid;grid-template-columns:repeat(7,minmax(0,1fr));gap:2px;max-width:280px;margin:0 auto;}
.na-cal-cell{aspect-ratio:1;border-radius:4px;background:${colorScheme[0]};display:flex;align-items:center;justify-content:center;font-size:0.6em;color:#5A6D75;cursor:pointer;transition:transform 0.1s;position:relative;}
.na-cal-cell:hover{transform:scale(1.08);}
.na-cal-cell[data-level="1"]{background:${colorScheme[1]};}
.na-cal-cell[data-level="2"]{background:${colorScheme[2]};color:#5A4A2A;}
.na-cal-cell[data-level="3"]{background:${colorScheme[3]};color:white;}
.na-cal-cell[data-level="4"]{background:${colorScheme[4]};color:white;}
.na-cal-cell.empty{background:transparent;cursor:default;}
.na-cal-cell.today{box-shadow:0 0 0 2px #E88E8E;font-weight:700;}
.na-month-bottom{display:flex;align-items:center;justify-content:center;gap:16px;margin-top:14px;flex-wrap:wrap;}

/* ---- 周视图：无图例，大号范围文字+右上标签 ---- */
.na-week-top{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:16px;}
.na-week-range{font-size:1.15em;font-weight:700;color:var(--text-normal);}
.na-week-row{display:flex;gap:10px;justify-content:space-between;}
.na-week-card{display:flex;flex-direction:column;align-items:center;gap:6px;flex:1;background:var(--background-secondary);border-radius:12px;padding:12px 6px;}
.na-week-card.today{background:rgba(232,142,142,0.12);}
.na-week-day{font-size:0.72em;color:#7A8B93;font-weight:600;}
.na-week-date{font-size:0.65em;color:#A9B7BC;}
.na-week-dot{width:22px;height:22px;border-radius:7px;background:${colorScheme[0]};cursor:pointer;}
.na-week-dot[data-level="1"]{background:${colorScheme[1]};}
.na-week-dot[data-level="2"]{background:${colorScheme[2]};}
.na-week-dot[data-level="3"]{background:${colorScheme[3]};}
.na-week-dot[data-level="4"]{background:${colorScheme[4]};}
.na-week-count{font-size:0.85em;font-weight:700;color:var(--interactive-accent);}

.na-tooltip{position:fixed;z-index:999;background:var(--background-primary);border:1px solid var(--background-modifier-border);border-radius:10px;padding:10px 14px;box-shadow:0 4px 16px rgba(0,0,0,0.15);font-size:0.8em;max-width:220px;display:none;pointer-events:none;}
.na-tooltip.show{display:block;}
.na-tooltip-date{font-weight:700;color:var(--text-normal);margin-bottom:4px;}
.na-tooltip-count{color:var(--interactive-accent);margin-bottom:4px;}
.na-tooltip-new-label{color:#E88E8E;font-weight:600;margin-top:4px;}
.na-tooltip-file{color:#7A8B93;font-size:0.92em;line-height:1.5;}
</style>
`;

function buildTooltipContent(dateStr) {
    const m = moment(dateStr, 'YYYY-MM-DD');
    const wk = weekdayFull[m.isoWeekday() - 1];
    const count = dateMap[dateStr] || 0;
    const created = createdMap[dateStr] || [];
    const focusMinutes = parseInt(localStorage.getItem(`focus-time-${dateStr}`) || '0', 10);
    let html = `<div class="na-tooltip-date">${m.format('M月D日')} ${wk}</div>`;
    html += `<div class="na-tooltip-count">${count} 次文件活动</div>`;
    if (focusMinutes > 0) {
        html += `<div class="na-tooltip-focus" style="color:#E8A0A0;font-weight:600;margin-top:4px;">⏱️ ${focusMinutes} 分钟专注</div>`;
    }
    if (created.length > 0) {
        html += `<div class="na-tooltip-new-label">新增</div>`;
        created.slice(0, 6).forEach(name => { html += `<div class="na-tooltip-file">${name}</div>`; });
        if (created.length > 6) html += `<div class="na-tooltip-file">…等 ${created.length} 篇</div>`;
    }
    return html;
}

function statsFor(dates) {
    let activeDays = 0, totalFiles = 0, newFiles = 0;
    dates.forEach(d => {
        const c = dateMap[d] || 0;
        if (c > 0) activeDays++;
        totalFiles += c;
        newFiles += (createdMap[d] || []).length;
    });
    return { activeDays, totalFiles, newFiles };
}

const tabsHtml = `<div class="na-tabs">
    <div class="na-tab" id="na-week">周</div>
    <div class="na-tab" id="na-month">月</div>
    <div class="na-tab" id="na-year">年</div>
</div>`;

function renderYear() {
    const today = moment();
    const start = today.clone().subtract(364, 'days');
    let allDates = [];
    for (let d = start.clone(); d.isSameOrBefore(today); d.add(1, 'day')) allDates.push(d.format('YYYY-MM-DD'));

    const gridStart = start.clone().startOf('isoWeek');
    let weeks = [], currentWeek = [];
    const monthPositions = [];
    let lastMonth = null;
    for (let d = gridStart.clone(); d.isSameOrBefore(today); d.add(1, 'day')) {
        const dateStr = d.format('YYYY-MM-DD');
        const inRange = d.isSameOrAfter(start);
        const count = inRange ? (dateMap[dateStr] || 0) : null;
        if (d.date() <= 7 && d.month() !== lastMonth) {
            monthPositions.push({ weekIndex: weeks.length, month: d.month() });
            lastMonth = d.month();
        }
        currentWeek.push(count === null ? null : { date: dateStr, count, level: levelOf(count) });
        if (currentWeek.length === 7) { weeks.push(currentWeek); currentWeek = []; }
    }
    if (currentWeek.length > 0) {
        while (currentWeek.length < 7) currentWeek.push(null);
        weeks.push(currentWeek);
    }
    const { activeDays, totalFiles, newFiles } = statsFor(allDates);
    const lessMore = lang === 'cn' ? `少 ${colorScheme.map(c => `<div class="na-legend-box" style="background:${c};"></div>`).join('')} 多` : `${colorScheme.map(c => `<div class="na-legend-box" style="background:${c};"></div>`).join('')}`;
    return `
    <div class="na-year-bar">
        <div class="na-range">${t.last365days}</div>
        ${tabsHtml}
        <div class="na-legend">${lessMore}</div>
    </div>
    <div class="na-scroll">
        <div class="na-months">
            ${monthPositions.map(m => `<span class="na-month-label" style="left:${m.weekIndex * 14 + 22}px;">${monthNamesCN[m.month]}</span>`).join('')}
        </div>
        <div class="na-body">
            <div class="na-wk-labels">${weekdayShort.map(w => `<span class="na-wk-label">${w}</span>`).join('')}</div>
            <div class="na-grid">
                ${weeks.map(week => `<div class="na-week">
                    ${week.map(day => day ? `<div class="na-pill ${day.date === todayStr ? 'today' : ''}" data-level="${day.level}" data-date="${day.date}"></div>` : '<div class="na-pill" style="background:transparent;"></div>').join('')}
                </div>`).join('')}
            </div>
        </div>
    </div>
    <div class="na-badges">
        <div class="na-badge">${activeDays} ${lang === 'cn' ? '个活跃日' : 'active days'}</div><div class="na-badge">${totalFiles} ${lang === 'cn' ? '次文件活动' : 'file updates'}</div><div class="na-badge">${lang === 'cn' ? '新增' : 'new'} ${newFiles} ${lang === 'cn' ? '篇' : 'notes'}</div>
    </div>`;
}

function renderMonth() {
    const start = moment().startOf('month');
    const end = moment().endOf('month');
    const gridStart = start.clone().startOf('isoWeek');
    const gridEnd = end.clone().endOf('isoWeek');
    let cells = [];
    for (let d = gridStart.clone(); d.isSameOrBefore(gridEnd); d.add(1, 'day')) {
        const inMonth = d.month() === start.month();
        const dateStr = d.format('YYYY-MM-DD');
        const count = inMonth ? (dateMap[dateStr] || 0) : null;
        cells.push(inMonth ? { date: dateStr, day: d.date(), count, level: levelOf(count) } : null);
    }
    const allDates = [];
    for (let d = start.clone(); d.isSameOrBefore(end); d.add(1, 'day')) allDates.push(d.format('YYYY-MM-DD'));
    const { activeDays, totalFiles, newFiles } = statsFor(allDates);
    const monthTitle = lang === 'cn' ? moment().format("YYYY年M月") : moment().format("YYYY-MM");
    const monthLessMore = lang === 'cn' ? `少 ${colorScheme.map(c => `<div class="na-legend-box" style="background:${c};"></div>`).join('')} 多` : `${colorScheme.map(c => `<div class="na-legend-box" style="background:${c};"></div>`).join('')}`;
    return `
    <div class="na-month-top">
        <div class="na-month-title">${monthTitle}</div>
        ${tabsHtml}
    </div>
    <div class="na-cal-weekdays">${weekdayShort.map(w => `<div class="na-cal-wk-label">${w}</div>`).join('')}</div>
    <div class="na-cal-grid">
        ${cells.map(c => c ? `<div class="na-cal-cell ${c.date === todayStr ? 'today' : ''}" data-level="${c.level}" data-date="${c.date}">${c.day}</div>` : `<div class="na-cal-cell empty"></div>`).join('')}
    </div>
    <div class="na-month-bottom">
        <div class="na-legend">${monthLessMore}</div>
        <div class="na-badges" style="margin-top:0;">
            <div class="na-badge">${activeDays} ${lang === 'cn' ? '个活跃日' : 'active days'}</div><div class="na-badge">${totalFiles} ${lang === 'cn' ? '次文件活动' : 'file updates'}</div><div class="na-badge">${lang === 'cn' ? '新增' : 'new'} ${newFiles} ${lang === 'cn' ? '篇' : 'notes'}</div>
        </div>
    </div>`;
}

function renderWeek() {
    const start = moment().subtract(6, 'days');
    let cells = [];
    for (let d = start.clone(); d.isSameOrBefore(moment()); d.add(1, 'day')) {
        const dateStr = d.format('YYYY-MM-DD');
        const count = dateMap[dateStr] || 0;
        const dayLabel = lang === 'cn' ? weekdayShort[d.isoWeekday() - 1] : moment.weekdays()[d.isoWeekday() % 7];
        cells.push({ date: dateStr, wk: dayLabel, md: d.format('M.D'), count, level: levelOf(count), isToday: dateStr === todayStr });
    }
    const allDates = cells.map(c => c.date);
    const { activeDays, totalFiles, newFiles } = statsFor(allDates);
    const weekRange = lang === 'cn' ? `${start.format("M月D日")} — ${moment().format("M月D日")}` : `${start.format("M/D")} — ${moment().format("M/D")}`;
    const weekPrefix = lang === 'cn' ? '周' : '';
    return `
    <div class="na-week-top">
        <div class="na-week-range">${weekRange}</div>
        ${tabsHtml}
    </div>
    <div class="na-week-row">
        ${cells.map(c => `
        <div class="na-week-card ${c.isToday ? 'today' : ''}">
            <div class="na-week-day">${weekPrefix}${c.wk}</div>
            <div class="na-week-dot" data-level="${c.level}" data-date="${c.date}"></div>
            <div class="na-week-count">${c.count}</div>
            <div class="na-week-date">${c.md}</div>
        </div>`).join('')}
    </div>
    <div class="na-badges" style="justify-content:center;">
        <div class="na-badge">${activeDays} ${lang === 'cn' ? '个活跃日' : 'active days'}</div><div class="na-badge">${totalFiles} ${lang === 'cn' ? '次文件活动' : 'file updates'}</div><div class="na-badge">${lang === 'cn' ? '新增' : 'new'} ${newFiles} ${lang === 'cn' ? '篇' : 'notes'}</div>
    </div>`;
}

function render() {
    let body;
    if (currentView === "year") body = renderYear();
    else if (currentView === "month") body = renderMonth();
    else body = renderWeek();

    container.innerHTML = style + `
    <div class="na-card">
        <div class="na-title">${t.noteActivity}</div>
        <div class="na-divider"></div>
        ${body}
        <div class="na-tooltip" id="na-tooltip"></div>
    </div>`;

    container.querySelector("#na-week").onclick = () => { currentView = "week"; render(); };
    container.querySelector("#na-month").onclick = () => { currentView = "month"; render(); };
    container.querySelector("#na-year").onclick = () => { currentView = "year"; render(); };
    container.querySelector(`#na-${currentView}`).classList.add("active");

    const tooltip = container.querySelector("#na-tooltip");
    container.querySelectorAll("[data-date]").forEach(pill => {
        pill.addEventListener("mouseenter", () => {
            const dateStr = pill.getAttribute("data-date");
            tooltip.innerHTML = buildTooltipContent(dateStr);
            tooltip.classList.add("show");
        });
        pill.addEventListener("mousemove", (e) => {
            tooltip.style.left = (e.clientX + 14) + "px";
            tooltip.style.top = (e.clientY + 14) + "px";
        });
        pill.addEventListener("mouseleave", () => {
            tooltip.classList.remove("show");
        });
    });
}

render();
```


```dataviewjs
// ⏲️ 表盘式专注时钟 - 双模式
// 多语言配置
const lang = localStorage.getItem('dashboardLang') || 'cn';
const i18n = {
  cn: {
    countdownMode: '⏱️ 倒计时',
    accumulateMode: '⏲️ 累加',
    setup: '设置:',
    minutes: '分钟',
    todayFocus: '今日专注',
    monthTotal: '本月统计',
    minuteUnit: '分钟',
    start: '▶ Start',
    pause: '⏸ Pause',
    reset: '↻ Reset'
  },
  en: {
    countdownMode: '⏱️ Countdown',
    accumulateMode: '⏲️ Accumulate',
    setup: 'Set:',
    minutes: 'min',
    todayFocus: 'Today Focus',
    monthTotal: 'Month Total',
    minuteUnit: 'min',
    start: '▶ Start',
    pause: '⏸ Pause',
    reset: '↻ Reset'
  }
};
const t = i18n[lang];

const container = dv.el("div", "");
const DEFAULT_FOCUS_TIME = 25 * 60; // 25分钟

const style = `<style>
/* ========== Design System ========== */
:root {
  --primary: #5B8DEF;
  --primary-light: #8FB8D9;
  --success: #5FA860;
  --warning: #F0A868;
  --danger: #E8A0A0;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 12px;
  --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.08);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.12);
  --shadow-lg: 0 12px 24px rgba(0, 0, 0, 0.16);
}

.pomodoro-dial-wrapper {
  background: linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);
  border: 1px solid rgba(154, 208, 180, 0.25);
  border-radius: var(--radius-lg);
  padding: 24px;
  box-shadow: 0 8px 32px rgba(93, 167, 110, 0.06);
  margin: 24px 0;
  display: flex;
  flex-direction: column;
  gap: 16px;
  font-family: 'Figtree', BlinkMacSystemFont, sans-serif;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.pomodoro-dial-wrapper:hover {
  border-color: rgba(93, 167, 110, 0.5);
  box-shadow: 0 12px 40px rgba(93, 167, 110, 0.12);
  background: linear-gradient(135deg, rgba(154, 208, 180, 0.15) 0%, rgba(93, 167, 110, 0.08) 100%);
}

@media (prefers-color-scheme: dark) {
  .pomodoro-dial-wrapper {
    background: linear-gradient(135deg, rgba(130, 190, 160, 0.15) 0%, rgba(65, 140, 90, 0.08) 100%);
    border-color: rgba(130, 190, 160, 0.3);
    box-shadow: 0 8px 32px rgba(65, 140, 90, 0.08);
  }
  .pomodoro-dial-wrapper:hover {
    border-color: rgba(130, 190, 160, 0.6);
    box-shadow: 0 12px 40px rgba(65, 140, 90, 0.15);
    background: linear-gradient(135deg, rgba(130, 190, 160, 0.2) 0%, rgba(65, 140, 90, 0.1) 100%);
  }
}

.pomo-mode-switch {
  display: flex;
  gap: 8px;
  width: 100%;
  border-bottom: 1px solid var(--background-modifier-border);
  padding-bottom: 16px;
}

.pomo-mode-btn {
  flex: 1;
  padding: 10px 14px;
  border: 1px solid var(--background-modifier-border);
  background: var(--background-secondary);
  color: var(--text-normal);
  border-radius: var(--radius-md);
  cursor: pointer;
  font-size: 0.8em;
  font-weight: 600;
  transition: all 0.2s ease;
}

.pomo-mode-btn:hover {
  border-color: var(--interactive-accent);
  background: rgba(91, 141, 239, 0.08);
}

.pomo-mode-btn.active {
  background: var(--interactive-accent);
  color: white;
  border-color: var(--interactive-accent);
  box-shadow: var(--shadow-sm);
}

.pomo-time-input {
  width: 80px;
  padding: 8px 10px;
  border: 1px solid var(--background-modifier-border);
  border-radius: var(--radius-md);
  background: var(--background-secondary);
  color: var(--text-normal);
  font-size: 0.85em;
  text-align: center;
  transition: all 0.2s ease;
  height: 36px;
}

.pomo-time-input:hover {
  border-color: var(--interactive-accent);
  background: var(--background-primary);
}

.pomo-time-input:focus {
  outline: none;
  border-color: var(--interactive-accent);
  box-shadow: 0 0 0 3px rgba(91, 141, 239, 0.1);
  background: var(--background-primary);
}
.pomo-dial {
  position: relative;
  width: 140px;
  height: 140px;
  flex-shrink: 0;
}
.pomo-canvas {
  width: 100%;
  height: 100%;
  filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
}
.pomo-content-row {
  display: flex;
  align-items: flex-start;
  gap: 20px;
}

.pomo-dial {
  flex-shrink: 0;
}

.pomo-info-section {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 12px;
  min-width: 0;
}
.pomo-title {
  font-size: 0.9em;
  font-weight: 600;
  color: var(--interactive-accent);
}
.pomo-stats {
  display: flex;
  gap: 16px;
  font-size: 0.85em;
  color: var(--text-normal);
}
.pomo-stat-item {
  display: flex;
  flex-direction: column;
  gap: 2px;
}
.pomo-stat-label {
  color: #8A9BA3;
  font-size: 0.75em;
}
.pomo-stat-value {
  font-weight: 700;
  color: var(--interactive-accent);
  font-size: 1.1em;
}
.pomo-controls {
  display: flex;
  gap: 8px;
  margin-top: 4px;
}
.pomo-btn {
  background: var(--interactive-accent);
  border: none;
  color: white;
  padding: 10px 16px;
  border-radius: var(--radius-md);
  cursor: pointer;
  font-size: 0.8em;
  font-weight: 600;
  transition: all 0.2s ease;
  flex: 1;
  box-shadow: var(--shadow-sm);
  min-height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.pomo-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(91, 141, 239, 0.25);
}

.pomo-btn:active {
  transform: translateY(0);
  box-shadow: var(--shadow-sm);
}

.pomo-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
}
</style>`;

const pomoHtml = `
<div class="pomodoro-dial-wrapper">
  <div class="pomo-mode-switch">
    <button class="pomo-mode-btn active" id="pomo-countdown-mode">${t.countdownMode}</button>
    <button class="pomo-mode-btn" id="pomo-accumulate-mode">${t.accumulateMode}</button>
  </div>
  <div class="pomo-content-row">
    <div class="pomo-dial">
      <canvas id="pomo-canvas" class="pomo-canvas" width="140" height="140"></canvas>
    </div>
    <div class="pomo-info-section">
    <div class="pomo-title">Focus Session</div>
    
    <div id="pomo-countdown-section" style="display: flex; gap: 8px; align-items: center; margin-bottom: 8px;">
      <label style="font-size: 0.8em; color: #8A9BA3;">${t.setup}</label>
      <input type="number" id="pomo-time-input" class="pomo-time-input" min="1" max="180" value="25" />
      <span style="font-size: 0.8em; color: #8A9BA3;">${t.minutes}</span>
      <button class="pomo-btn" id="pomo-set-time" style="flex: 0; padding: 6px 12px; font-size: 0.75em;">✓</button>
    </div>
    
    <div class="pomo-stats">
      <div class="pomo-stat-item">
        <div class="pomo-stat-label">${t.todayFocus}</div>
        <div class="pomo-stat-value" id="pomo-today">0${t.minuteUnit}</div>
      </div>
      <div class="pomo-stat-item">
        <div class="pomo-stat-label">${t.monthTotal}</div>
        <div class="pomo-stat-value" id="pomo-month">0${t.minuteUnit}</div>
      </div>
    </div>
    <div class="pomo-controls">
      <button class="pomo-btn" id="pomo-start">${t.start}</button>
      <button class="pomo-btn" id="pomo-pause">${t.pause}</button>
      <button class="pomo-btn" id="pomo-reset">${t.reset}</button>
    </div>
  </div>
  </div>
</div>
`;

container.innerHTML = style + pomoHtml;

// 全局状态管理
window._pomoState = window._pomoState || {
  isRunning: false,
  mode: 'countdown', // 'countdown' 或 'accumulate'
  remaining: DEFAULT_FOCUS_TIME,
  focusTime: DEFAULT_FOCUS_TIME,
  totalElapsed: 0,
  startTime: null,
  intervalId: null
};

const canvas = container.querySelector('#pomo-canvas');
const ctx = canvas.getContext('2d');
const startBtn = container.querySelector('#pomo-start');
const pauseBtn = container.querySelector('#pomo-pause');
const resetBtn = container.querySelector('#pomo-reset');
const countdownModeBtn = container.querySelector('#pomo-countdown-mode');
const accumulateModeBtn = container.querySelector('#pomo-accumulate-mode');
const setTimeBtn = container.querySelector('#pomo-set-time');
const timeInput = container.querySelector('#pomo-time-input');
const countdownSection = container.querySelector('#pomo-countdown-section');

// 获取主题颜色
function getThemeColors() {
  const style = getComputedStyle(document.body);
  return {
    accentColor: style.getPropertyValue('--interactive-accent').trim() || '#8FB8D9',
    textNormal: style.getPropertyValue('--text-normal').trim() || '#000000',
    bgSecondary: style.getPropertyValue('--background-secondary').trim() || '#f5f5f5'
  };
}

function drawDial() {
  const centerX = canvas.width / 2;
  const centerY = canvas.height / 2;
  const radius = 60;
  
  let progress = 0;
  let displayTime = 0;
  
  if (window._pomoState.mode === 'countdown') {
    // 倒计时模式
    progress = (window._pomoState.focusTime - window._pomoState.remaining) / window._pomoState.focusTime;
    displayTime = window._pomoState.remaining;
  } else {
    // 累加模式
    progress = Math.min(window._pomoState.totalElapsed / window._pomoState.focusTime, 1);
    displayTime = window._pomoState.totalElapsed;
  }
  
  const colors = getThemeColors();

  // 清空画布
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // 背景圆
  ctx.fillStyle = colors.bgSecondary;
  ctx.beginPath();
  ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
  ctx.fill();

  // 进度圆环背景（淡化的主题色）
  ctx.strokeStyle = colors.accentColor + '33';
  ctx.lineWidth = 4;
  ctx.beginPath();
  ctx.arc(centerX, centerY, radius - 2, 0, Math.PI * 2);
  ctx.stroke();

  // 进度圆环（主题强调色）
  ctx.strokeStyle = colors.accentColor;
  ctx.lineWidth = 5;
  ctx.lineCap = 'round';
  ctx.beginPath();
  ctx.arc(centerX, centerY, radius - 2, -Math.PI / 2, -Math.PI / 2 + Math.PI * 2 * progress);
  ctx.stroke();

  // 中心时间显示
  const mins = Math.floor(displayTime / 60);
  const secs = displayTime % 60;
  const timeStr = `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
  
  ctx.font = 'bold 24px Figtree, sans-serif';
  ctx.fillStyle = colors.textNormal;
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(timeStr, centerX, centerY);

  // 状态指示
  if (window._pomoState.isRunning) {
    ctx.font = 'bold 10px Figtree, sans-serif';
    ctx.fillStyle = colors.accentColor;
    const modeText = window._pomoState.mode === 'countdown' ? (lang === 'cn' ? '倒计时' : 'Countdown') : (lang === 'cn' ? '累加中' : 'Accumulate');
    ctx.fillText(modeText, centerX, centerY + 35);
  }
}

function updateStats() {
  const today = moment().format('YYYY-MM-DD');
  const todayMinutes = parseInt(localStorage.getItem(`focus-time-${today}`) || '0', 10);
  
  let monthTotal = 0;
  const monthStart = moment().startOf('month');
  const monthEnd = moment().endOf('month');
  for (let d = monthStart.clone(); d.isSameOrBefore(monthEnd); d.add(1, 'day')) {
    const ds = d.format('YYYY-MM-DD');
    monthTotal += parseInt(localStorage.getItem(`focus-time-${ds}`) || '0', 10);
  }
  
  container.querySelector('#pomo-today').textContent = todayMinutes + t.minuteUnit;
  container.querySelector('#pomo-month').textContent = monthTotal + t.minuteUnit;
}

function saveFocusData(minutes) {
  const today = moment().format('YYYY-MM-DD');
  const storageKey = `focus-time-${today}`;
  const existing = parseInt(localStorage.getItem(storageKey) || '0', 10);
  localStorage.setItem(storageKey, existing + minutes);
}

function startTimer() {
  if (window._pomoState.isRunning) return;
  window._pomoState.isRunning = true;
  const startTime = Date.now();
  if (!window._pomoState.startTime) {
    window._pomoState.startTime = startTime;
  }
  
  window._pomoState.intervalId = setInterval(() => {
    if (window._pomoState.mode === 'countdown') {
      // 倒计时模式
      if (window._pomoState.remaining > 0) {
        window._pomoState.remaining--;
        drawDial();
      } else {
        clearInterval(window._pomoState.intervalId);
        window._pomoState.isRunning = false;
        const completedMinutes = window._pomoState.focusTime / 60;
        saveFocusData(completedMinutes);
        updateStats();
        drawDial();
        const msg = lang === 'cn' ? ('🎉 专注时间完成！已记录 ' + Math.round(completedMinutes) + ' 分钟') : ('🎉 Focus completed! Recorded ' + Math.round(completedMinutes) + ' min');
        new Notice(msg);
      }
    } else {
      // 累加模式 - 不停止，一直累加
      window._pomoState.totalElapsed++;
      drawDial();
    }
  }, 1000);
}

// 模式切换
function switchMode(newMode) {
  if (window._pomoState.isRunning) {
    const msg = lang === 'cn' ? '请先停止计时器再切换模式' : 'Please stop timer before switching mode';
    new Notice(msg);
    return;
  }
  
  window._pomoState.mode = newMode;
  window._pomoState.remaining = window._pomoState.focusTime;
  window._pomoState.totalElapsed = 0;
  window._pomoState.startTime = null;
  
  if (newMode === 'countdown') {
    countdownModeBtn.classList.add('active');
    accumulateModeBtn.classList.remove('active');
    countdownSection.style.display = 'flex';
  } else {
    accumulateModeBtn.classList.add('active');
    countdownModeBtn.classList.remove('active');
    countdownSection.style.display = 'none';
  }
  
  drawDial();
  const switchMsg = lang === 'cn' ? ('已切换到 ' + (newMode === 'countdown' ? '⏱️ 倒计时模式' : '⏲️ 累加计时')) : ('Switched to ' + (newMode === 'countdown' ? '⏱️ Countdown' : '⏲️ Accumulate'));
  new Notice(switchMsg);
}

countdownModeBtn.onclick = () => switchMode('countdown');
accumulateModeBtn.onclick = () => switchMode('accumulate');

setTimeBtn.onclick = () => {
  const mins = parseInt(timeInput.value);
  if (mins < 1 || mins > 180) {
    const msg = lang === 'cn' ? '请输入 1-180 分钟之间的时间' : 'Please enter time between 1-180 minutes';
    new Notice(msg);
    return;
  }
  window._pomoState.focusTime = mins * 60;
  window._pomoState.remaining = mins * 60;
  drawDial();
  const setMsg = lang === 'cn' ? ('⏱️ 已设置专注时间为 ' + mins + ' 分钟') : ('⏱️ Focus time set to ' + mins + ' min');
  new Notice(setMsg);
};

startBtn.onclick = startTimer;

pauseBtn.onclick = () => {
  if (window._pomoState.intervalId) {
    clearInterval(window._pomoState.intervalId);
    window._pomoState.isRunning = false;
    drawDial();
  }
};

resetBtn.onclick = () => {
  if (window._pomoState.intervalId) {
    clearInterval(window._pomoState.intervalId);
  }
  
  if (window._pomoState.mode === 'countdown') {
    window._pomoState.isRunning = false;
    window._pomoState.remaining = window._pomoState.focusTime;
  } else {
    // 累加模式下重置时保存数据
    if (window._pomoState.totalElapsed > 0) {
      const minutes = Math.round(window._pomoState.totalElapsed / 60);
      saveFocusData(minutes);
      updateStats();
      const msg = lang === 'cn' ? ('✅ 已保存累加时间: ' + minutes + ' 分钟') : ('✅ Saved accumulated time: ' + minutes + ' min');
      new Notice(msg);
    }
    window._pomoState.isRunning = false;
    window._pomoState.totalElapsed = 0;
    window._pomoState.startTime = null;
  }
  
  drawDial();
};

drawDial();
updateStats();
```


```dataviewjs 
// ┌──────────────────────────────────────┐
// │         📦 加载依赖                    │
// └──────────────────────────────────────┘

if (typeof Chart === 'undefined') {
    const s = document.createElement('script');
    s.src = 'https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js';
    document.head.appendChild(s);
    await new Promise(resolve => {
        s.onload = resolve;
        s.onerror = () => resolve();
    });
}

// ============ 多语言配置 ============
const lang = localStorage.getItem('dashboardLang') || 'cn';
const i18n = {
  cn: {
    noteActivity: '笔记活动',
    projectsBoard: '项目概览',
    taskboard: '任务统计',
    taskDetails: '任务详情',
    today: '今日',
    todo: '待办',
    done: '完成',
    projects: '项目',
    tasks: '任务',
    recentEdited: '最近编辑',
    totalNotes: '总笔记数量',
    totalWords: '总字数',
    totalLinks: '总链接数',
    last365days: '最近 365 天',
    noTodayTasks: '暂无今日任务',
    noTodoTasks: '没有待办任务',
    noDoneTasks: '还没有完成的任务'
  },
  en: {
    noteActivity: 'Note Activity',
    projectsBoard: 'Projects Board',
    taskboard: 'Taskboard',
    taskDetails: 'Task Details',
    today: 'Today',
    todo: 'Todo',
    done: 'Done',
    projects: 'Projects',
    tasks: 'Tasks',
    recentEdited: 'Recently Edited',
    totalNotes: 'Total Notes',
    totalWords: 'Total Words',
    totalLinks: 'Total Links',
    last365days: 'Last 365 Days',
    noTodayTasks: 'No tasks today',
    noTodoTasks: 'No tasks',
    noDoneTasks: 'No completed tasks'
  }
};
const t = i18n[lang];

// ┌──────────────────────────────────────┐
// │            🎨 配置区                  │
// └──────────────────────────────────────┘

var CHART_DISPLAY_SIZE = 24;
var CHART_RESOLUTION = 2;
var CANVAS_SIZE = CHART_DISPLAY_SIZE * CHART_RESOLUTION;
var CUTOUT_PERCENT = "65%";

// ┌──────────────────────────────────────┐
// │         📊 项目进度数据                │
// └──────────────────────────────────────┘

var allProjects = [];
var statusIcon = { active: "▶", paused: "⏸", done: "✓", backlog: "○" };
var prioOrder = { high: 3, medium: 2, low: 1 };

// 同步方式：使用 dv.pages 获取项目数据
try {
    var allPages = dv.pages().array();
    for (var p of allPages) {
        if (p && p.file && p.file.name === 'Project List' && p.projects) {
            if (Array.isArray(p.projects)) {
                allProjects = p.projects.map(function(proj) {
                    return {
                        name: proj && proj.name ? proj.name : '',
                        status: proj && proj.status ? proj.status : 'active',
                        priority: proj && proj.priority ? proj.priority : 'medium',
                        progress: proj && proj.progress ? parseInt(proj.progress) : 0
                    };
                }).filter(function(proj) { return proj.name.length > 0; });
            }
            break;
        }
    }
} catch (e) {
    console.log('项目加载错误:', e);
    allProjects = [];
}

var activeProjects = allProjects.filter(function(p) { return p.status !== "done"; });
activeProjects.sort(function(a, b) {
    return (prioOrder[b.priority || "low"] || 0) - (prioOrder[a.priority || "low"] || 0);
});

function makeProgressBar(pct) {
    var val = pct || 0;
    var filled = Math.round(val / 10);
    var empty = 10 - filled;
    var result = "";
    for (var i = 0; i < filled; i++) {
        result = result + "<span style='color:#6B9E8A;font-size:0.85em'>█</span>";
    }
    for (var i = 0; i < empty; i++) {
        result = result + "<span style='color:#E6E9DC;font-size:0.85em'>█</span>";
    }
    result = result + " <span style='color:var(--interactive-accent);font-size:0.8em'>" + val + "%</span>";
    return result;
}

// ┌──────────────────────────────────────┐
// │          🖼️ 渲染双栏：项目 + 任务      │
// └──────────────────────────────────────┘

var container = dv.el("div", "");
var h = "";

h = h + "<style>";
h = h + ".ph-container{margin:8px 0;}";
h = h + ".ph-section{background:linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);backdrop-filter:blur(10px);border:1px solid rgba(154, 208, 180, 0.25);border-radius:16px;padding:18px 20px;box-shadow:0 8px 32px rgba(93, 167, 110, 0.06);margin-bottom:24px;}";
h = h + "@media (prefers-color-scheme: dark) { .ph-section{background:linear-gradient(135deg, rgba(130, 190, 160, 0.13) 0%, rgba(65, 140, 90, 0.07) 100%);border-color:rgba(130, 190, 160, 0.28);box-shadow:0 8px 32px rgba(65, 140, 90, 0.07);} }";
h = h + ".ph-title{font-weight:bold;margin:0;padding:0;font-size:0.95em;color:var(--interactive-accent);line-height:1.3;margin-bottom:12px;text-align:center;}";

// 项目卡片网格
h = h + ".ph-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:12px;margin-top:8px;}";
h = h + ".ph-card{background:linear-gradient(135deg, rgba(154, 208, 180, 0.2) 0%, rgba(93, 167, 110, 0.1) 100%);border:1px solid rgba(154, 208, 180, 0.35);border-radius:10px;padding:14px;transition:all 0.2s;cursor:pointer;}";
h = h + "@media (prefers-color-scheme: dark) { .ph-card{background:linear-gradient(135deg, rgba(130, 190, 160, 0.22) 0%, rgba(65, 140, 90, 0.12) 100%);border-color:rgba(130, 190, 160, 0.4);} }";
h = h + ".ph-card:hover{transform:translateY(-2px);box-shadow:0 4px 12px rgba(0,0,0,0.1);border-color:var(--interactive-accent);}";
h = h + ".ph-card-name{font-weight:600;font-size:0.95em;color:var(--text-normal);margin-bottom:8px;word-break:break-word;}";
h = h + ".ph-card-meta{display:flex;gap:8px;font-size:0.82em;color:var(--text-muted);margin-bottom:8px;flex-wrap:wrap;align-items:center;}";
h = h + ".ph-card-badge{background:var(--interactive-accent);color:white;padding:3px 10px;border-radius:4px;font-size:0.8em;font-weight:600;white-space:nowrap;}";
h = h + ".ph-card-progress{margin-top:8px;}";

// Tasks 样式
h = h + ".ph-tasks-row{display:flex;gap:12px;flex-wrap:wrap;}";
h = h + ".ph-tasks-col{flex:1;min-width:150px;}";
h = h + ".tasks-container{margin-top:8px;}";
h = h + ".tasks-item{margin:6px 0;display:flex;align-items:center;gap:6px;}";
h = h + ".tasks-item:first-child{margin-top:0;}";
h = h + ".tasks-label{font-size:0.75em;margin-top:0;color:var(--interactive-accent);font-weight:500;}";
h = h + ".ph-empty{font-size:0.82em;color:var(--text-muted);font-style:italic;}";
h = h + "</style>";

h = h + "<div class='ph-container'>";

// Projects Board 部分
h = h + "<div class='ph-section'>";
h = h + "<div class='ph-title'>🎯 " + t.projectsBoard + "</div>";

if (activeProjects.length === 0) {
    h = h + "<div class='ph-empty'>No ongoing projects</div>";
} else {
    h = h + "<div class='ph-grid'>";
    for (var pi = 0; pi < activeProjects.length; pi++) {
        var proj = activeProjects[pi];
        var icon = statusIcon[proj.status] || "⚪";
        var prioColor = proj.priority === 'high' ? '#E8A0A0' : (proj.priority === 'medium' ? '#F0A868' : '#8A9BA3');
        h = h + "<div class='ph-card'>";
        h = h + "<div class='ph-card-name'>" + (proj.name || "") + "</div>";
        h = h + "<div class='ph-card-meta'>";
        h = h + "<span class='ph-card-badge' style='background:" + prioColor + "'>" + (proj.priority || "-") + "</span>";
        h = h + "<span style='color:var(--text-muted)'>" + icon + " " + (proj.status || "unknown") + "</span>";
        h = h + "</div>";
        h = h + "<div class='ph-card-progress'>" + makeProgressBar(proj.progress) + "</div>";
        h = h + "</div>";
    }
    h = h + "</div>";
}
h = h + "</div>";

// Taskboard 部分
h = h + "<div class='ph-section'>";
h = h + "<div class='ph-title'>📊 " + t.taskboard + "</div>";
h = h + "<div class='ph-tasks-row'>";

var todayStr = moment().format("YYYY-MM-DD");
var weekStart = moment().startOf('isoWeek').format("YYYY-MM-DD");
var monthStart = moment().startOf('month').format("YYYY-MM-DD");

var todayTasks = 0, weekTasks = 0, monthTasks = 0;

var workPagesAll = dv.pages('"Dashboard"').array ? dv.pages('"Dashboard"').array() : dv.pages('"Dashboard"');
var workPagesArray = workPagesAll.filter(function(p) { return p && p.file && p.file.name && p.file.name.includes("List"); });

for (var page of workPagesArray) {
    var fileContent = await dv.io.load(page.file.path);
    if (!fileContent) continue;
    var lines = fileContent.split("\n");
    for (var li = 0; li < lines.length; li++) {
        var line = lines[li];
        var m = line.match(/^-\s*\[x\]\s*.+✅\s*(\d{4}-\d{2}-\d{2})/);
        if (!m) continue;
        var d = m[1];
        if (d === todayStr) todayTasks++;
        if (d >= weekStart) weekTasks++;
        if (d >= monthStart) monthTasks++;
    }
}

var todayTarget = 5, weekTarget = 25, monthTarget = 100;

window._taskData = [
    { completed: todayTasks, target: todayTarget, label: "today", color: "#E7BA86" },
    { completed: weekTasks, target: weekTarget, label: "week", color: "#829E8F" },
    { completed: monthTasks, target: monthTarget, label: "month", color: "#DDA3A2" }
];

for (var ti = 0; ti < window._taskData.length; ti++) {
    var item = window._taskData[ti];
    var chartId = "ph-task-ring-" + ti;
    var labelText = (item.label === 'today' ? (lang === 'cn' ? '今日' : 'Today') : (item.label === 'week' ? (lang === 'cn' ? '本周' : 'Week') : (lang === 'cn' ? '本月' : 'Month')));
    h = h + "<div class='ph-tasks-col'>";
    h = h + "<div class='tasks-container'>";
    h = h + "<div class='tasks-item'>";
    h = h + "<canvas id='" + chartId + "' width='" + CANVAS_SIZE + "' height='" + CANVAS_SIZE + "' style='width:" + CHART_DISPLAY_SIZE + "px;height:" + CHART_DISPLAY_SIZE + "px;'></canvas>";
    h = h + "<div class='tasks-label'>" + labelText + " ✓" + item.completed + "</div>";
    h = h + "</div>";
    h = h + "</div>";
    h = h + "</div>";
}

h = h + "</div>"; // 结束 ph-tasks-row

// ┌──────────────────────────────────────┐
// │      📋 Task Details - 任务详情      │
// └──────────────────────────────────────┘

// 获取项目任务数据
const detailProjectPages = dv.pages('"Dashboard"').array ? dv.pages('"Dashboard"').array() : dv.pages('"Dashboard"');
const detailProjectArray = detailProjectPages.filter(p => p && p.file && p.file.name && p.file.name.includes("List"));
const tasks = { today: [], todo: [], done: [] };

for (const page of detailProjectArray) {
  if (!page || !page.file) continue;
  const content = await dv.io.load(page.file.path);
  if (!content) continue;
  const lines = content.split("\n");
  for (const line of lines) {
    const taskMatch = line.match(/^-\s*\[([x\s])\]\s*(.+)$/i);
    if (!taskMatch) continue;
    const isDone = taskMatch[1].toLowerCase() === 'x';
    const fullText = taskMatch[2].trim();
    const isPinned = /📌/.test(fullText);
    const tagMatches = fullText.matchAll(/#([\w-/]+)/g);
    const tags = Array.from(tagMatches).map(m => m[1]);
    let taskName = fullText.replace(/📌/g, '').replace(/#[\w-/]+/g, '').replace(/✅\s*\d{4}-\d{2}-\d{2}/g, '').trim();
    if (tags.some(t => t.startsWith('habit'))) continue;
    const isHighPriority = tags.includes('priority/high');
    const taskObj = { name: taskName, priority: isHighPriority ? 'high' : 'normal', isDone: isDone, tags: tags, pinned: isPinned };
    if (isDone) {
      tasks.done.push(taskObj);
    } else {
      const dateMatch = line.match(/✅\s*(\d{4}-\d{2}-\d{2})/);
      if (dateMatch && dateMatch[1] === todayStr) {
        tasks.today.push(taskObj);
      } else {
        tasks.todo.push(taskObj);
      }
    }
  }
}

function sortTasksByPriority(taskList) {
  return taskList.sort((a, b) => {
    if (a.pinned && !b.pinned) return -1;
    if (!a.pinned && b.pinned) return 1;
    if (a.priority === 'high' && b.priority !== 'high') return -1;
    if (a.priority !== 'high' && b.priority === 'high') return 1;
    return 0;
  });
}

const taskLimit = 15;
let detailTodayTasks = sortTasksByPriority(tasks.today).slice(0, taskLimit);
let detailTodoTasks = sortTasksByPriority(tasks.todo).slice(0, taskLimit);
const detailDoneTasks = sortTasksByPriority(tasks.done).slice(0, taskLimit);

h = h + "<div style='margin-top: 20px; padding-top: 20px; border-top: 1px solid rgba(200,200,200,0.2);'>";
h = h + "<div style='font-size: 0.9em; font-weight: 600; color: var(--interactive-accent); margin-bottom: 12px;'>📋 " + t.taskDetails + "</div>";
h = h + "<div style='display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 12px;'>";

// Today
h = h + "<div style='border-radius: 10px; overflow: hidden; border: 2px solid #F0A868;'>";
h = h + "<div style='background: linear-gradient(135deg, #F0A868 0%, rgba(240, 168, 104, 0.8) 100%); color: white; font-weight: 700; padding: 12px; font-size: 0.92em;'>🎯 " + t.today + " <span style=\"background: var(--interactive-accent); padding: 2px 8px; border-radius: 12px; font-size: 0.75em;\">" + detailTodayTasks.length + "</span></div>";
h = h + "<div style='padding: 8px; max-height: 300px; overflow-y: auto;'>";
if (detailTodayTasks.length === 0) {
  h = h + "<div style='text-align: center; padding: 20px; color: var(--text-muted); font-size: 0.8em;'>" + t.noTodayTasks + "</div>";
} else {
  for (const task of detailTodayTasks) {
    h = h + "<div style='padding: 8px 10px; margin-bottom: 6px; border-radius: 6px; background: var(--background-primary); font-size: 0.8em; " + (task.priority === 'high' ? 'border-left: 4px solid #E8A0A0; background: rgba(232, 160, 160, 0.15);' : '') + "'>";
    h = h + (task.pinned ? '📌 ' : '') + task.name;
    h = h + "</div>";
  }
}
h = h + "</div></div>";

// Todo
h = h + "<div style='border-radius: 10px; overflow: hidden; border: 2px solid #8FB8D9;'>";
h = h + "<div style='background: linear-gradient(135deg, #8FB8D9 0%, rgba(143, 184, 217, 0.8) 100%); color: white; font-weight: 700; padding: 12px; font-size: 0.92em;'>📝 " + t.todo + " <span style=\"background: var(--interactive-accent); padding: 2px 8px; border-radius: 12px; font-size: 0.75em;\">" + detailTodoTasks.length + "</span></div>";
h = h + "<div style='padding: 8px; max-height: 300px; overflow-y: auto;'>";
if (detailTodoTasks.length === 0) {
  h = h + "<div style='text-align: center; padding: 20px; color: var(--text-muted); font-size: 0.8em;'>" + t.noTodoTasks + "</div>";
} else {
  for (const task of detailTodoTasks) {
    h = h + "<div style='padding: 8px 10px; margin-bottom: 6px; border-radius: 6px; background: var(--background-primary); font-size: 0.8em; " + (task.priority === 'high' ? 'border-left: 4px solid #E8A0A0; background: rgba(232, 160, 160, 0.15);' : '') + "'>";
    h = h + (task.pinned ? '📌 ' : '') + task.name;
    h = h + "</div>";
  }
}
h = h + "</div></div>";

// Done
h = h + "<div style='border-radius: 10px; overflow: hidden; border: 2px solid #C8AADC;'>";
h = h + "<div style='background: linear-gradient(135deg, #C8AADC 0%, rgba(154, 208, 180, 0.8) 100%); color: white; font-weight: 700; padding: 12px; font-size: 0.92em;'>✅ " + t.done + " <span style=\"background: var(--interactive-accent); padding: 2px 8px; border-radius: 12px; font-size: 0.75em;\">" + detailDoneTasks.length + "</span></div>";
h = h + "<div style='padding: 8px; max-height: 300px; overflow-y: auto;'>";
if (detailDoneTasks.length === 0) {
  h = h + "<div style='text-align: center; padding: 20px; color: var(--text-muted); font-size: 0.8em;'>" + t.noDoneTasks + "</div>";
} else {
  for (const task of detailDoneTasks) {
    h = h + "<div style='padding: 8px 10px; margin-bottom: 6px; text-decoration: line-through; opacity: 0.5; font-size: 0.8em;'>";
    h = h + (task.pinned ? '📌 ' : '') + task.name;
    h = h + "</div>";
  }
}
h = h + "</div></div>";

h = h + "</div></div>";

h = h + "</div>"; // 结束 ph-section
h = h + "</div>"; // 结束 ph-container

container.innerHTML = h;

// 语言切换事件处理
setTimeout(function() {
    const langBtns = container.querySelectorAll('.lang-btn');
    langBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const newLang = this.getAttribute('data-lang');
            localStorage.setItem('dashboardLang', newLang);
            location.reload();
        });
    });
}, 100);

// 渲染Tasks环形图
setTimeout(function() {
    var taskData = window._taskData || [];
    for (var ti = 0; ti < taskData.length; ti++) {
        var item = taskData[ti];
        var chartId = "ph-task-ring-" + ti;
        var canvas = container.querySelector("#" + chartId);
        if (!canvas) continue;
        var ctx = canvas.getContext("2d");
        var rate = Math.min(Math.round((item.completed / item.target) * 100), 100);
        var bgColor = item.color;
        new Chart(ctx, {
            type: "doughnut",
            data: { datasets: [{ data: [rate, 100 - rate], backgroundColor: [bgColor, "#E0E0E0"], borderWidth: 0 }] },
            options: { responsive: false, maintainAspectRatio: false, cutout: CUTOUT_PERCENT, plugins: { legend: { display: false }, tooltip: { enabled: false } } }
        });
    }
}, 300);
```


```dataviewjs
// 多语言配置
const lang = localStorage.getItem('dashboardLang') || 'cn';
const i18n = {
  cn: { recentEdited: '最近编辑' },
  en: { recentEdited: 'Recently Edited' }
};
const t = i18n[lang];

const allPages = dv.pages().where(p => p.file.mtime);
const recentEdited = allPages.sort(p => p.file.mtime, 'desc').limit(5);

const container = dv.el("div", "");
let h = `<style>
.rc-wrap{background:linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);backdrop-filter:blur(10px);border:1px solid rgba(154, 208, 180, 0.25);border-radius:16px;padding:18px 20px;box-shadow:0 8px 32px rgba(93, 167, 110, 0.06);margin-bottom:24px;} @media (prefers-color-scheme: dark) { .rc-wrap{background:linear-gradient(135deg, rgba(130, 190, 160, 0.13) 0%, rgba(65, 140, 90, 0.07) 100%);border-color:rgba(130, 190, 160, 0.28);box-shadow:0 8px 32px rgba(65, 140, 90, 0.07);} }
.rc-title{font-weight:600;font-size:0.85em;color:var(--interactive-accent);margin-bottom:6px;}
.rc-table{width:100%;border-collapse:collapse;font-size:0.78em;}
.rc-table td{padding:3px 4px;color:var(--text-normal);}
.rc-table a{color:var(--interactive-accent);text-decoration:none;}
.rc-time{color:#8A9BA3;font-size:0.85em;white-space:nowrap;}
</style><div class="rc-wrap">`;
h += `<div class="rc-title">📝 ${t.recentEdited}</div><table class="rc-table">`;
for (const p of recentEdited) h += `<tr><td><a data-href="${p.file.path}" class="internal-link">${p.file.name}</a></td><td class="rc-time">${moment(p.file.mtime.toString()).format("M-D HH:mm")}</td></tr>`;
h += `</table></div>`;
container.innerHTML = h;
```

```dataviewjs
// 多语言配置
const lang = localStorage.getItem('dashboardLang') || 'cn';
const i18n = {
  cn: { totalNotes: '总笔记数量', totalWords: '总字数', totalLinks: '总链接数' },
  en: { totalNotes: 'Total Notes', totalWords: 'Total Words', totalLinks: 'Total Links' }
};
const t = i18n[lang];

const pages = dv.pages();
let totalWords = 0;
for (const p of pages) {
    const content = await dv.io.load(p.file.path);
    if (content) totalWords += content.split(/\s+/).filter(Boolean).length;
}
const totalLinks = pages.array().reduce((sum, p) => sum + (p.file.outlinks ? p.file.outlinks.length : 0), 0);

const container = dv.el("div", "");
container.innerHTML = `<style>
.stat-row{display:flex;gap:10px;flex-wrap:wrap;background:linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);backdrop-filter:blur(10px);border:1px solid rgba(154, 208, 180, 0.25);border-radius:16px;padding:18px 20px;box-shadow:0 8px 32px rgba(93, 167, 110, 0.06);margin-bottom:24px;} @media (prefers-color-scheme: dark) { .stat-row{background:linear-gradient(135deg, rgba(130, 190, 160, 0.13) 0%, rgba(65, 140, 90, 0.07) 100%);border-color:rgba(130, 190, 160, 0.28);box-shadow:0 8px 32px rgba(65, 140, 90, 0.07);} }
.stat-card{flex:1;min-width:100px;background:var(--background-secondary);border-radius:10px;padding:10px 14px;text-align:center;}
.stat-num{font-size:1.3em;font-weight:700;color:var(--interactive-accent);}
.stat-label{font-size:0.72em;color:#8A9BA3;margin-top:2px;}
</style>
<div class="stat-row">
    <div class="stat-card"><div class="stat-num">${pages.length}</div><div class="stat-label">${t.totalNotes}</div></div>
    <div class="stat-card"><div class="stat-num">${totalWords.toLocaleString()}</div><div class="stat-label">${t.totalWords}</div></div>
    <div class="stat-card"><div class="stat-num">${totalLinks}</div><div class="stat-label">${t.totalLinks}</div></div>
</div>`;
```

```dataviewjs
// 多语言配置
const lang = localStorage.getItem('dashboardLang') || 'cn';
const i18n = {
  cn: { wordTrend: '近12个月字数趋势', tagRatio: '标签占比' },
  en: { wordTrend: 'Last 12 Months Words', tagRatio: 'Tag Distribution' }
};
const t = i18n[lang];

if (typeof Chart === 'undefined') {
    await new Promise((resolve, reject) => {
        const s = document.createElement('script');
        s.src = 'https://cdn.jsdelivr.net/npm/chart.js';
        s.onload = resolve; s.onerror = reject;
        document.head.appendChild(s);
    });
}

const pages = dv.pages();
const monthlyWords = {}; const months = [];
for (let i = 11; i >= 0; i--) {
    const m = moment().subtract(i, 'months').format('YYYY-MM');
    months.push(m); monthlyWords[m] = 0;
}
for (const p of pages) {
    if (!p.file.ctime) continue;
    const m = moment(p.file.ctime.toString()).format('YYYY-MM');
    if (monthlyWords[m] === undefined) continue;
    const content = await dv.io.load(p.file.path);
    if (content) monthlyWords[m] += content.split(/\s+/).filter(Boolean).length;
}
const tagCounts = {};
for (const p of pages) for (const tag of (p.file.tags || [])) tagCounts[tag] = (tagCounts[tag] || 0) + 1;
const sortedTags = Object.entries(tagCounts).sort((a, b) => b[1] - a[1]).slice(0, 6);

const container = dv.el("div", "");
container.innerHTML = `<style>.chart-row{display:flex;gap:16px;flex-wrap:wrap;align-items:center;background:linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);backdrop-filter:blur(10px);border:1px solid rgba(154, 208, 180, 0.25);border-radius:16px;padding:18px 20px;box-shadow:0 8px 32px rgba(93, 167, 110, 0.06);margin-bottom:24px;} @media (prefers-color-scheme: dark) { .chart-row{background:linear-gradient(135deg, rgba(130, 190, 160, 0.13) 0%, rgba(65, 140, 90, 0.07) 100%);border-color:rgba(130, 190, 160, 0.28);box-shadow:0 8px 32px rgba(65, 140, 90, 0.07);} }
.chart-col{flex:1;min-width:240px;}.chart-title{font-size:0.85em;font-weight:600;color:var(--interactive-accent);margin-bottom:4px;}</style>
<div class="chart-row">
<div class="chart-col"><div class="chart-title">${t.wordTrend}</div><canvas id="word-trend-chart" height="140"></canvas></div>
<div class="chart-col" style="max-width:220px;"><div class="chart-title">${t.tagRatio}</div><canvas id="tag-donut-chart" height="140"></canvas></div>
</div>`;

setTimeout(() => {
    new Chart(container.querySelector("#word-trend-chart").getContext("2d"), {
        type: "bar",
        data: { labels: months.map(m => moment(m, 'YYYY-MM').format('M月')), datasets: [{ data: months.map(m => monthlyWords[m]), backgroundColor: "#9ECF13", borderRadius: 4 }] },
        options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } }
    });
    new Chart(container.querySelector("#tag-donut-chart").getContext("2d"), {
        type: "doughnut",
        data: { labels: sortedTags.map(t => t[0]), datasets: [{ data: sortedTags.map(t => t[1]), backgroundColor: ['#C8AADC', '#F3D98C', '#F0A868', '#E88E8E', '#8FB8D9', '#C9A9D6'] }] },
        options: { plugins: { legend: { position: 'bottom', labels: { font: { size: 9 } } } } }
    });
}, 200);
```

```dataviewjs
const container = dv.el("div", "");
function renderList() {
    const manifests = app.plugins.manifests;
    const enabledPlugins = app.plugins.enabledPlugins;
    const ids = Object.keys(manifests).sort((a, b) => manifests[a].name.localeCompare(manifests[b].name));

    let h = `<style>
    .pl-list{max-height:260px;overflow-y:auto;font-size:0.8em;background:linear-gradient(135deg, rgba(154, 208, 180, 0.12) 0%, rgba(93, 167, 110, 0.06) 100%);border:1px solid rgba(154, 208, 180, 0.25);border-radius:14px;padding:12px 16px;box-shadow:0 2px 6px rgba(93, 167, 110, 0.08);backdrop-filter:blur(10px);} @media (prefers-color-scheme: dark) { .pl-list{background:linear-gradient(135deg, rgba(130, 190, 160, 0.13) 0%, rgba(65, 140, 90, 0.07) 100%);border-color:rgba(130, 190, 160, 0.28);box-shadow:0 2px 6px rgba(65, 140, 90, 0.1);} }
    .pl-item{display:flex;align-items:center;justify-content:space-between;padding:4px 6px;border-bottom:1px solid var(--background-modifier-border);}
    .pl-toggle{width:30px;height:16px;border-radius:8px;background:#C9D4D8;position:relative;cursor:pointer;}
    .pl-toggle.on{background:#6B9E8A;}
    .pl-toggle-knob{position:absolute;top:2px;left:2px;width:12px;height:12px;border-radius:50%;background:white;transition:left 0.15s;}
    .pl-toggle.on .pl-toggle-knob{left:16px;}
    </style><div class="pl-list">`;
    for (const id of ids) {
        const isOn = enabledPlugins.has(id);
        h += `<div class="pl-item"><span>${manifests[id].name}</span><div class="pl-toggle ${isOn ? 'on' : ''}" data-id="${id}"><div class="pl-toggle-knob"></div></div></div>`;
    }
    h += `</div>`;
    container.innerHTML = h;
    container.querySelectorAll(".pl-toggle").forEach(t => {
        t.onclick = async () => {
            const id = t.getAttribute("data-id");
            if (app.plugins.enabledPlugins.has(id)) await app.plugins.disablePlugin(id);
            else await app.plugins.enablePlugin(id);
            renderList();
        };
    });
}
renderList();
```
