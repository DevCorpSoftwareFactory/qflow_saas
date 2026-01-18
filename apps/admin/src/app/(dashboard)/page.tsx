"use client"
import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Activity, CreditCard, DollarSign, Users, ArrowUpRight, ArrowDownRight } from "lucide-react"
import { dashboardService } from "@/services/dashboard.service"
import { DashboardMetricsDto } from "@qflow/shared"

// Locally defined interface not needed anymore, using shared DTO

export default function DashboardPage() {
    // TODO: Connect to real API endpoint (Task 3.1.4)
    // For now, we initialize with null/loading state to avoid "hardcoded data" anti-pattern
    // and simulate a fetch to show structure.
    const [metrics, setMetrics] = useState<DashboardMetricsDto | null>(null);
    const [loading, setLoading] = useState<boolean>(true);

    useEffect(() => {
        const fetchMetrics = async () => {
            try {
                const data = await dashboardService.getSummary();
                setMetrics(data);
            } catch (error) {
                console.error("Failed to fetch dashboard metrics:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchMetrics();
    }, []);

    if (loading) {
        return <div className="p-8 flex items-center justify-center">Cargando tablero...</div>;
    }

    return (
        <div className="flex-1 space-y-4 p-8 pt-6">
            <div className="flex items-center justify-between space-y-2">
                <h2 className="text-3xl font-bold tracking-tight">Tablero Ejecutivo</h2>
                <div className="flex items-center space-x-2">
                    {/* DatePicker or Actions could go here */}
                </div>
            </div>
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                <Card className="hover:shadow-md transition-shadow">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                        <CardTitle className="text-sm font-medium">Ingresos Totales (Mes)</CardTitle>
                        <DollarSign className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">${metrics?.totalRevenue.toLocaleString('en-US', { minimumFractionDigits: 2 })}</div>
                        <div className="text-xs text-muted-foreground flex items-center mt-1">
                            <ArrowUpRight className="h-4 w-4 text-emerald-500 mr-1" />
                            <span className="text-emerald-500 font-medium">+{metrics?.revenueGrowth}%</span>
                            <span className="ml-1">vs mes anterior</span>
                        </div>
                    </CardContent>
                </Card>
                <Card className="hover:shadow-md transition-shadow">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                        <CardTitle className="text-sm font-medium">Ventas (7 días)</CardTitle>
                        <CreditCard className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">+{metrics?.salesCount}</div>
                        <div className="text-xs text-muted-foreground flex items-center mt-1">
                            <ArrowUpRight className="h-4 w-4 text-emerald-500 mr-1" />
                            <span className="text-emerald-500 font-medium">+{metrics?.salesGrowth}%</span>
                            <span className="ml-1">vs semana anterior</span>
                        </div>
                    </CardContent>
                </Card>
                <Card className="hover:shadow-md transition-shadow">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                        <CardTitle className="text-sm font-medium">Ticket Promedio</CardTitle>
                        <Activity className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">${metrics?.averageTicket.toFixed(2)}</div>
                        <div className="text-xs text-muted-foreground flex items-center mt-1">
                            <ArrowDownRight className="h-4 w-4 text-rose-500 mr-1" />
                            <span className="text-rose-500 font-medium">{metrics?.ticketGrowth}%</span>
                            <span className="ml-1">vs mes anterior</span>
                        </div>
                    </CardContent>
                </Card>
                <Card className="hover:shadow-md transition-shadow">
                    <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                        <CardTitle className="text-sm font-medium">Sesiones Activas</CardTitle>
                        <Users className="h-4 w-4 text-muted-foreground" />
                    </CardHeader>
                    <CardContent>
                        <div className="text-2xl font-bold">{metrics?.activeSessions}</div>
                        <div className="text-xs text-muted-foreground mt-1">
                            +2 cajeros activos desde hace 1h
                        </div>
                    </CardContent>
                </Card>
            </div>

            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-7">
                <Card className="col-span-4 hover:shadow-md transition-shadow">
                    <CardHeader>
                        <CardTitle>Resumen de Ventas</CardTitle>
                        <CardDescription>
                            Rendimiento de los últimos 30 días.
                        </CardDescription>
                    </CardHeader>
                    <CardContent className="pl-2">
                        <div className="h-[200px] w-full bg-slate-100 dark:bg-slate-800/50 rounded-md flex items-center justify-center border border-dashed">
                            <p className="text-muted-foreground text-sm">Gráfico de Ventas (Pendiente Integración Recharts)</p>
                        </div>
                    </CardContent>
                </Card>
                <Card className="col-span-3 hover:shadow-md transition-shadow">
                    <CardHeader>
                        <CardTitle>Ventas Recientes</CardTitle>
                        <CardDescription>
                            Últimas 5 transacciones completadas.
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="space-y-4">
                            {metrics?.recentSales.map((sale) => (
                                <div key={sale.id} className="flex items-center justify-between border-b pb-2 last:border-0 last:pb-0">
                                    <div className="flex items-center gap-3">
                                        <div className="h-9 w-9 rounded-full bg-primary/10 flex items-center justify-center">
                                            <span className="text-primary font-bold text-xs">OM</span>
                                        </div>
                                        <div className="space-y-0.5">
                                            <p className="text-sm font-medium leading-none">Orden #{sale.orderId}</p>
                                            <p className="text-xs text-muted-foreground">Hace {sale.time}</p>
                                        </div>
                                    </div>
                                    <div className="font-bold text-sm">
                                        +${sale.amount.toFixed(2)}
                                    </div>
                                </div>
                            ))}
                        </div>
                    </CardContent>
                </Card>
            </div>
        </div>
    )
}
