"use client"

import Link from "next/link"
import { usePathname } from "next/navigation"
import { useState, useEffect } from "react"
import {
    BarChart3,
    Box,
    CreditCard,
    LayoutDashboard,
    Settings,
    ShoppingCart,
    Store,
    Users,
} from "lucide-react"

import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"

export function Sidebar({ className }: React.HTMLAttributes<HTMLDivElement>) {
    const pathname = usePathname()

    const mainNav = [
        { name: "Panel General", href: "/", icon: LayoutDashboard },
        { name: "Ventas", href: "/sales", icon: ShoppingCart },
        { name: "Inventario", href: "/inventory", icon: Box },
        { name: "Cajas y POS", href: "/pos-ops", icon: Store },
    ]

    const managementNav = [
        { name: "Clientes", href: "/customers", icon: Users },
        { name: "Tesorería", href: "/accounting", icon: CreditCard },
        { name: "Reportes", href: "/reports", icon: BarChart3 },
    ]

    const systemNav = [
        { name: "General", href: "/settings/general", icon: Settings },
        { name: "Impuestos", href: "/settings/taxes", icon: CreditCard }, // Reusing CreditCard or similar
        { name: "Facturación", href: "/settings/billing", icon: Box }, // Reusing Box or similar
        { name: "Seguridad", href: "/settings/security", icon: Settings },
        { name: "Mi Perfil", href: "/settings/profile", icon: Users },
    ]

    const [companyName, setCompanyName] = useState<string>("QFlow ERP");

    // Lazy load settings service to avoid circular deps if any, or just use it.
    // Importing SettingsService at top level.

    useEffect(() => {
        // Fetch company settings to get name
        const fetchSettings = async () => {
            try {
                // We need to dynamically import or ensure SettingsService is available
                // Assuming it is available from standard import
                const settings = await import("@/services/settings.service").then(m => m.SettingsService.getCompanySettings());
                if (settings.name) {
                    setCompanyName(settings.name);
                }
            } catch (error) {
                console.error("Failed to load company settings for sidebar", error);
            }
        };
        fetchSettings();
    }, []);

    return (
        <div className={cn("flex flex-col h-full bg-card border-r shadow-sm", className)}>
            <div className="p-6">
                <div className="flex items-center gap-3">
                    <div className="h-10 w-10 rounded-xl bg-gradient-to-br from-primary to-violet-600 flex items-center justify-center shadow-lg shadow-primary/25">
                        <Store className="h-6 w-6 text-white" />
                    </div>
                    <div>
                        <h2 className="text-xl font-bold tracking-tight text-foreground">
                            QFlow <span className="text-primary">Pro</span>
                        </h2>
                        <p className="text-xs text-muted-foreground font-medium">Enterprise ERP</p>
                    </div>
                </div>
            </div>

            <div className="flex-1 overflow-y-auto py-2 px-4 space-y-6">
                <div>
                    <h3 className="mb-2 px-2 text-xs font-semibold uppercase text-muted-foreground tracking-wider">
                        Principal
                    </h3>
                    <div className="space-y-1">
                        {mainNav.map((item) => (
                            <Link key={item.href} href={item.href}>
                                <Button
                                    variant="ghost"
                                    className={cn(
                                        "w-full justify-start text-sm font-medium h-10",
                                        pathname === item.href
                                            ? "bg-primary/10 text-primary hover:bg-primary/15"
                                            : "text-muted-foreground hover:bg-muted/50 hover:text-foreground"
                                    )}
                                >
                                    <item.icon className={cn("mr-3 h-4 w-4", pathname === item.href ? "text-primary" : "text-muted-foreground/70")} />
                                    {item.name}
                                </Button>
                            </Link>
                        ))}
                    </div>
                </div>

                <div>
                    <h3 className="mb-2 px-2 text-xs font-semibold uppercase text-muted-foreground tracking-wider">
                        Gestión
                    </h3>
                    <div className="space-y-1">
                        {managementNav.map((item) => (
                            <Link key={item.href} href={item.href}>
                                <Button
                                    variant="ghost"
                                    className={cn(
                                        "w-full justify-start text-sm font-medium h-10",
                                        pathname === item.href
                                            ? "bg-primary/10 text-primary hover:bg-primary/15"
                                            : "text-muted-foreground hover:bg-muted/50 hover:text-foreground"
                                    )}
                                >
                                    <item.icon className={cn("mr-3 h-4 w-4", pathname === item.href ? "text-primary" : "text-muted-foreground/70")} />
                                    {item.name}
                                </Button>
                            </Link>
                        ))}
                    </div>
                </div>

                <div>
                    <h3 className="mb-2 px-2 text-xs font-semibold uppercase text-muted-foreground tracking-wider">
                        Sistema
                    </h3>
                    <div className="space-y-1">
                        {systemNav.map((item) => (
                            <Link key={item.href} href={item.href}>
                                <Button
                                    variant="ghost"
                                    className={cn(
                                        "w-full justify-start text-sm font-medium h-10",
                                        pathname === item.href
                                            ? "bg-primary/10 text-primary hover:bg-primary/15"
                                            : "text-muted-foreground hover:bg-muted/50 hover:text-foreground"
                                    )}
                                >
                                    <item.icon className={cn("mr-3 h-4 w-4", pathname === item.href ? "text-primary" : "text-muted-foreground/70")} />
                                    {item.name}
                                </Button>
                            </Link>
                        ))}
                    </div>
                </div>
            </div>

            <div className="p-4 border-t bg-muted/20">
                <div className="rounded-lg bg-card border p-3 shadow-sm">
                    <div className="flex items-center gap-3">
                        <div className="rounded-full bg-green-100 p-1.5 dark:bg-green-900/30">
                            <div className="h-2 w-2 rounded-full bg-green-500 animate-pulse" />
                        </div>
                        <div className="space-y-0.5">
                            <p className="text-xs font-medium">{companyName}</p>
                            <p className="text-[10px] text-muted-foreground">En línea</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
