"use client"

import { Sidebar } from "@/components/layout/sidebar"
import { Header } from "@/components/layout/header"
import { useAuth } from "@/hooks/use-auth"
import { useRouter } from "next/navigation"
import { useEffect } from "react"
import { Loader2 } from "lucide-react"

export default function DashboardLayout({
    children,
}: {
    children: React.ReactNode
}) {
    const { user, loading } = useAuth()
    const router = useRouter()

    useEffect(() => {
        if (!loading && !user) {
            router.push("/auth/login")
        }
    }, [loading, user, router])

    if (loading) {
        return (
            <div className="flex h-screen items-center justify-center">
                <Loader2 className="h-8 w-8 animate-spin text-primary" />
            </div>
        )
    }

    if (!user) {
        return null // Will redirect
    }

    return (
        <div className="flex min-h-screen">
            <div className="hidden border-r bg-gray-100/40 lg:block w-64 lg:fixed lg:inset-y-0">
                <Sidebar />
            </div>
            <div className="flex-1 lg:pl-64 flex flex-col min-h-screen">
                <Header />
                <main className="flex-1 p-6 space-y-4">
                    {children}
                </main>
            </div>
        </div>
    )
}
