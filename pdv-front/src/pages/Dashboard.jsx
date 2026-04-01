import { useState, useEffect } from 'react';
import useDocumentTitle from '../hooks/useDocumentTitle';
import api from '../api/axios';
import StatsCard from '../components/dashboard/StatsCard';
import ConsultasChart from '../components/dashboard/ConsultasChart';
import TopListCard from '../components/dashboard/TopListCard';

const Dashboard = () => {
    useDocumentTitle('Dashboard');
    const [stats, setStats] = useState({
        packages: 0,
        flights: 0,
        accommodations: 0,
        blogPosts: 0,
        consultas: 0,
    });
    const [topPackages, setTopPackages] = useState([]);
    const [topFlights, setTopFlights] = useState([]);
    const [topPosts, setTopPosts] = useState([]);
    const [consultasData, setConsultasData] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchDashboardData = async () => {
            try {
                const [pkgRes, flightRes, hotelRes, blogRes, consultaRes] = await Promise.allSettled([
                    api.get('/packages'),
                    api.get('/flights'),
                    api.get('/accommodations'),
                    api.get('/blog-posts'),
                    api.get('/consultas'),
                ]);

                const packages = pkgRes.status === 'fulfilled' ? (pkgRes.value.data || []) : [];
                const flights = flightRes.status === 'fulfilled' ? (flightRes.value.data || []) : [];
                const hotels = hotelRes.status === 'fulfilled' ? (hotelRes.value.data || []) : [];
                const blogs = blogRes.status === 'fulfilled' ? (blogRes.value.data || []) : [];
                const consultas = consultaRes.status === 'fulfilled' ? (consultaRes.value.data || []) : [];

                // Ensure arrays
                const pkgArr = Array.isArray(packages) ? packages : [];
                const flightArr = Array.isArray(flights) ? flights : [];
                const hotelArr = Array.isArray(hotels) ? hotels : [];
                const blogArr = Array.isArray(blogs) ? blogs : [];
                const consultaArr = Array.isArray(consultas) ? consultas : [];

                setStats({
                    packages: pkgArr.length,
                    flights: flightArr.length,
                    accommodations: hotelArr.length,
                    blogPosts: blogArr.length,
                    consultas: consultaArr.length,
                });

                // Top packages by name
                setTopPackages(
                    pkgArr
                        .filter(p => p.post?.name)
                        .slice(0, 5)
                        .map(p => p.post.name)
                );

                // Top flights by destination
                setTopFlights(
                    flightArr
                        .filter(f => f.destination || f.post?.name)
                        .slice(0, 5)
                        .map(f => f.destination || f.post?.name)
                );

                // Top blog posts by name
                setTopPosts(
                    blogArr
                        .filter(b => b.name || b.post?.name)
                        .slice(0, 5)
                        .map(b => b.name || b.post?.name)
                );

                // Build weekly consultas chart data (group by day of week)
                const weekCounts = [0, 0, 0, 0, 0, 0, 0]; // Mon-Sun
                consultaArr.forEach(c => {
                    const date = new Date(c.created_at);
                    if (!isNaN(date.getTime())) {
                        // getDay: 0=Sun, 1=Mon...6=Sat → convert to Mon=0...Sun=6
                        const day = (date.getDay() + 6) % 7;
                        weekCounts[day]++;
                    }
                });
                setConsultasData(weekCounts);
            } catch (err) {
                console.error('Dashboard fetch error:', err);
            } finally {
                setLoading(false);
            }
        };
        fetchDashboardData();
    }, []);

    const STATS_CARDS = [
        { label: 'Paquetes Activos', value: stats.packages, to: '/dashboard/paquetes' },
        { label: 'Vuelos', value: stats.flights, to: '/dashboard/vuelos' },
        { label: 'Hoteles', value: stats.accommodations, to: '/dashboard/hoteles' },
        { label: 'Posts Blog', value: stats.blogPosts, to: '/dashboard/blog' },
        { label: 'Consultas Realizadas', value: stats.consultas, to: '/dashboard/consultas' },
    ];

    return (
        <div className="p-6 space-y-6">
            {/* Page title */}
            <div id="tour-dashboard-card">
                <h1 className="text-2xl font-extrabold text-[#001f6c]">Dashboard</h1>
                <p className="text-sm text-[#8898aa] mt-0.5">
                    Resumen general del sitio web
                </p>
            </div>

            {/* ── Row 1: Stats cards ─────────────────────────────── */}
            <div id="tour-stats-row" className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-4">
                {STATS_CARDS.map((s) => (
                    <StatsCard
                        key={s.label}
                        label={s.label}
                        value={loading ? '–' : s.value}
                        to={s.to}
                    />
                ))}
            </div>

            {/* ── Row 2: Chart ───────────────────────────────────── */}
            <div id="tour-consultas-chart">
                <ConsultasChart
                    data={consultasData}
                    loading={loading}
                    to="/dashboard/consultas"
                />
            </div>

            {/* ── Row 3: Top lists ───────────────────────────────── */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <TopListCard
                    title="Paquete más consultado"
                    items={topPackages}
                    to="/dashboard/paquetes"
                />
                <TopListCard
                    title="Vuelos más consultado"
                    items={topFlights}
                    to="/dashboard/vuelos"
                />
                <TopListCard
                    title="Post más visitado"
                    items={topPosts}
                    to="/dashboard/blog"
                />
            </div>
        </div>
    );
};

export default Dashboard;
