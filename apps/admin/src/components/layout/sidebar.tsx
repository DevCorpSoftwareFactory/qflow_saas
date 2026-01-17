"use client"

import Link from "next/link"
import { usePathname } from "next/navigation"
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

interface SidebarProps extends React.HTMLAttributes<HTMLDivElement> { }

export function Sidebar({ className }: SidebarProps) {
    const pathname = usePathname()

    const items = [
        { name: "Dashboard", href: "/", icon: LayoutDashboard },
        { name: "Sales", href: "/sales", icon: ShoppingCart },
        { name: "Inventory", href: "/inventory", icon: Box },
        { name: "Customers", href: "/customers", icon: Users },
        { name: "Accounting", href: "/accounting", icon: CreditCard },
        { name: "POS Operations", href: "/pos-ops", icon: Store },
        { name: "Reports", href: "/reports", icon: BarChart3 },
        { name: "Settings", href: "/settings", icon: Settings },
    ]

    return (
        <div className={cn("pb-12 bg-gray-50/40 dark:bg-gray-900/40 border-r min-h-screen", className)}>
            <div className="space-y-4 py-4">
                <div className="px-3 py-2">
                    <h2 className="mb-2 px-4 text-xl font-bold tracking-tight text-primary">
                        QFlow Pro
                    </h2>
                    <div className="space-y-1">
                        {items.map((item) => (
                            <Link key={item.href} href={item.href}>
                                <Button
                                    variant={pathname === item.href ? "secondary" : "ghost"}
                                    className="w-full justify-start"
                                >
                                    <item.icon className="mr-2 h-4 w-4" />
                                    {item.name}
                                </Button>
                            </Link>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    )
}
