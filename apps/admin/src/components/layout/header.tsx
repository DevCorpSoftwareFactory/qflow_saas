"use client"

import Link from "next/link"
import { useAuth } from "@/hooks/use-auth"
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"

import { Bell, Search } from "lucide-react"

export function Header() {
    const { user, logout } = useAuth()

    return (
        <header className="sticky top-0 z-30 flex h-16 items-center gap-4 border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 px-6 shadow-sm">
            <div className="flex flex-1 items-center gap-4">
                <div className="w-full max-w-md hidden md:block">
                    <div className="relative">
                        <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                        <input
                            type="search"
                            placeholder="Buscar en QFlow..."
                            className="flex h-9 w-full rounded-md border border-input bg-muted/50 px-3 py-1 text-sm shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50 pl-9"
                        />
                    </div>
                </div>
            </div>
            <div className="flex items-center gap-4">
                <Button variant="ghost" size="icon" className="relative text-muted-foreground hover:text-foreground">
                    <Bell className="h-5 w-5" />
                    <span className="absolute top-2 right-2 h-2 w-2 rounded-full bg-red-500 border border-background" />
                    <span className="sr-only">Notificaciones</span>
                </Button>

                <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                        <Button variant="ghost" className="relative h-9 rounded-full pl-2 pr-4 ring-offset-background transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2">
                            <div className="flex items-center gap-3">
                                <Avatar className="h-8 w-8 border border-border">
                                    <AvatarImage src={user?.avatarUrl || undefined} alt={user?.email || "Usuario"} />
                                    <AvatarFallback className="bg-primary text-primary-foreground font-semibold">
                                        {(user?.fullName || "U").charAt(0)}
                                    </AvatarFallback>
                                </Avatar>
                                <div className="flex flex-col items-start space-y-0.5 hidden md:flex">
                                    <span className="text-sm font-medium leading-none">{user?.fullName || 'Usuario'}</span>
                                    <span className="text-xs text-muted-foreground truncate max-w-[120px]">
                                        {user?.roleName || 'Admin'}
                                    </span>
                                </div>
                            </div>
                        </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent className="w-56" align="end" forceMount>
                        <DropdownMenuLabel className="font-normal">
                            <div className="flex flex-col space-y-1">
                                <p className="text-sm font-medium leading-none">{user?.fullName}</p>
                                <p className="text-xs leading-none text-muted-foreground">
                                    {user?.email}
                                </p>
                            </div>
                        </DropdownMenuLabel>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem asChild className="cursor-pointer">
                            <Link href="/settings/profile" className="w-full">
                                Perfil
                            </Link>
                        </DropdownMenuItem>
                        <DropdownMenuItem asChild className="cursor-pointer">
                            <Link href="/settings/general" className="w-full">
                                Configuración
                            </Link>
                        </DropdownMenuItem>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem className="text-destructive focus:text-destructive cursor-pointer group" onClick={() => logout()}>
                            <span className="group-hover:font-semibold">Cerrar Sesión</span>
                        </DropdownMenuItem>
                    </DropdownMenuContent>
                </DropdownMenu>
            </div>
        </header>
    )
}
