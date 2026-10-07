// Dashboard Charts - Extracted from card.blade.php
// Load via: <script src="{{ asset('js/dashboard/charts.js') }}"></script>

// ============ DATA INJECTION ============
// These will be populated by blade template via window.dashboardData
window.dashboardData = window.dashboardData || {};

// ============ CHART INSTANCES ============
let visitorChart = null;
let deviceChart = null;
let agendaStatusChart = null;
let aduanStatusChart = null;
let aduanKategoriChart = null;
let aduanTrenChart = null;

// ============ UTILITIES ============
function getCanvas(id) {
    const el = document.getElementById(id);
    return el ? el.getContext('2d') : null;
}

function destroyChart(chart) {
    if (chart) {
        chart.destroy();
        return null;
    }
    return chart;
}

// ============ VISITOR CHART ============
function createVisitorChart(type = 'daily') {
    const data = window.dashboardData.visitorStats;
    if (!data) return;

    const labels = type === 'daily' ? data.daily.labels : data.monthly.labels;
    const totalData = type === 'daily' ? data.daily.total : data.monthly.total;
    const uniqueData = type === 'daily' ? data.daily.unique : data.monthly.unique;

    visitorChart = destroyChart(visitorChart);

    const ctx = getCanvas('visitorChart');
    if (!ctx) return;

    visitorChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Total Kunjungan',
                data: totalData,
                borderColor: '#5e72e4',
                backgroundColor: 'rgba(94, 114, 228, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.3,
                pointRadius: 4,
                pointHoverRadius: 6,
            }, {
                label: 'Pengunjung Unik',
                data: uniqueData,
                borderColor: '#2dce89',
                backgroundColor: 'rgba(45, 206, 137, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.3,
                pointRadius: 4,
                pointHoverRadius: 6,
            }]
        },
        options: getLineChartOptions()
    });
}

function switchVisitorChart(type, btn) {
    document.querySelectorAll('[data-chart-type]').forEach(b => b.classList.remove('active'));
    if (btn) btn.classList.add('active');
    createVisitorChart(type);
}

// ============ DEVICE CHART ============
async function createDeviceChart() {
    try {
        const response = await fetch(window.dashboardData.routes?.deviceStats || '/backend/dashboard/device-stats');
        const data = await response.json();

        deviceChart = destroyChart(deviceChart);

        const ctx = getCanvas('deviceChart');
        if (!ctx) return;

        deviceChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: data.labels,
                datasets: [{
                    data: data.values,
                    backgroundColor: ['#5e72e4', '#2dce89', '#fb6340', '#f5365c'],
                    borderWidth: 0,
                    hoverOffset: 10,
                }]
            },
            options: getDoughnutOptions('bottom', 11)
        });
    } catch (err) {
        console.error('Failed to load device stats:', err);
    }
}

// ============ AGENDA STATUS CHART ============
function createAgendaStatusChart() {
    const data = window.dashboardData.agendas;
    if (!data) return;

    agendaStatusChart = destroyChart(agendaStatusChart);

    const ctx = getCanvas('agendaStatusChart');
    if (!ctx) return;

    agendaStatusChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Dipublikasikan', 'Draft'],
            datasets: [{
                data: [data.published, data.total - data.published],
                backgroundColor: ['#2dce89', '#fb6340'],
                borderWidth: 0,
                hoverOffset: 10,
            }]
        },
        options: getDoughnutOptions(false, 11, false)
    });
}

// ============ ADUAN STATUS CHART ============
function createAduanStatusChart() {
    const data = window.dashboardData.aduanPerStatus;
    if (!data) return;

    aduanStatusChart = destroyChart(aduanStatusChart);

    const ctx = getCanvas('aduanStatusChart');
    if (!ctx) return;

    aduanStatusChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Menunggu', 'Diverifikasi', 'Diproses', 'Selesai', 'Ditolak'],
            datasets: [{
                data: data,
                backgroundColor: ['#8898aa', '#11cdef', '#fb6340', '#2dce89', '#f5365c'],
                borderWidth: 0,
                hoverOffset: 10,
            }]
        },
        options: getDoughnutOptions(false, 11, false)
    });
}

// ============ ADUAN KATEGORI CHART ============
function createAduanKategoriChart() {
    const labels = window.dashboardData.aduanKategoriLabels;
    const data = window.dashboardData.aduanKategoriData;
    if (!labels || !data) return;

    aduanKategoriChart = destroyChart(aduanKategoriChart);

    const ctx = getCanvas('aduanKategoriChart');
    if (!ctx) return;

    aduanKategoriChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Jumlah Aduan',
                data: data,
                backgroundColor: ['#11cdef', '#fb6340', '#825ee4', '#f5365c', '#2dce89', '#ffd600', '#0d99c7', '#e91e63', '#8bc34a'],
                borderRadius: 6,
            }]
        },
        options: getBarChartOptions()
    });
}

// ============ ADUAN TREN CHART ============
function createAduanTrenChart() {
    const labels = window.dashboardData.aduanTrenLabels;
    const data = window.dashboardData.aduanTrenData;
    if (!labels || !data) return;

    aduanTrenChart = destroyChart(aduanTrenChart);

    const ctx = getCanvas('aduanTrenChart');
    if (!ctx) return;

    aduanTrenChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Aduan Masuk',
                data: data,
                borderColor: '#fb6340',
                backgroundColor: 'rgba(251, 99, 64, 0.12)',
                fill: true,
                tension: 0.4,
                pointRadius: 4,
            }]
        },
        options: getLineChartOptions(false, true)
    });
}

// ============ SHARED OPTIONS ============
function getLineChartOptions(showLegend = true, beginAtZero = true) {
    return {
        responsive: true,
        maintainAspectRatio: false,
        interaction: { intersect: false, mode: 'index' },
        plugins: {
            legend: {
                position: 'top',
                display: showLegend,
                labels: { usePointStyle: true, padding: 20, font: { size: 12 } }
            },
            tooltip: {
                backgroundColor: '#fff',
                titleColor: '#344767',
                bodyColor: '#67748e',
                borderColor: '#e9ecef',
                borderWidth: 1,
                padding: 12,
                displayColors: true,
                callbacks: {
                    label: function(context) {
                        return context.dataset.label + ': ' + context.raw.toLocaleString();
                    }
                }
            }
        },
        scales: {
            y: {
                beginAtZero: beginAtZero,
                grid: { color: '#f1f5f9' },
                ticks: { callback: v => v.toLocaleString() }
            },
            x: { grid: { display: false }, ticks: { maxRotation: 0, autoSkip: true, maxTicksLimit: 8, font: { size: 11 } } }
        }
    };
}

function getDoughnutOptions(legendPosition = 'bottom', fontSize = 11, showLegend = true) {
    return {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '70%',
        plugins: {
            legend: {
                position: legendPosition,
                display: showLegend,
                labels: { usePointStyle: true, padding: 15, font: { size: fontSize } }
            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        const total = context.dataset.data.reduce((a, b) => a + b, 0);
                        const pct = total > 0 ? ((context.raw / total) * 100).toFixed(1) : 0;
                        return context.label + ': ' + context.raw.toLocaleString() + ' (' + pct + '%)';
                    }
                }
            }
        }
    };
}

function getBarChartOptions() {
    return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
            y: { beginAtZero: true, ticks: { precision: 0 } },
            x: { ticks: { maxRotation: 45, minRotation: 0, font: { size: 10 } } }
        }
    };
}

// ============ INIT ============
function initDashboardCharts() {
    // Wait for Chart.js to load
    if (typeof Chart === 'undefined') {
        setTimeout(initDashboardCharts, 100);
        return;
    }

    createVisitorChart('daily');
    createDeviceChart();
    createAgendaStatusChart();
    createAduanStatusChart();
    createAduanKategoriChart();
    createAduanTrenChart();
}

// Expose globally for tab switching
window.switchVisitorChart = switchVisitorChart;

// Re-render charts when bootstrap tab becomes visible (hidden canvas has 0 size otherwise)
function refreshVisibleCharts() {
    [visitorChart, deviceChart, agendaStatusChart, aduanStatusChart, aduanKategoriChart, aduanTrenChart].forEach(function(c) {
        if (c && typeof c.resize === 'function') { try { c.resize(); c.update(); } catch(e) {} }
    });
}

document.addEventListener('shown.bs.tab', function(e) {
    // slight delay agar tab sudah display:block
    setTimeout(refreshVisibleCharts, 80);
});

// Auto-init on DOM ready
document.addEventListener('DOMContentLoaded', function() {
    initDashboardCharts();
    // fallback: refresh after window load
    window.addEventListener('load', function() { setTimeout(refreshVisibleCharts, 200); });
});