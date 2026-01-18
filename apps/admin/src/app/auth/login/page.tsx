"use client"

import * as React from "react"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from "zod"
import { Loader2 } from "lucide-react"
import Link from "next/link"

import { Button } from "@/components/ui/button"
import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { useAuth } from "@/hooks/use-auth"

const loginSchema = z.object({
    email: z.string().email("Por favor ingresa un correo válido"),
    password: z.string().min(6, "La contraseña debe tener al menos 6 caracteres"),
})

type LoginFormValues = z.infer<typeof loginSchema>

export default function LoginPage() {
    const { login, isLoading, error } = useAuth()

    const form = useForm<LoginFormValues>({
        resolver: zodResolver(loginSchema),
        defaultValues: {
            email: "",
            password: "",
        },
    })

    async function onSubmit(values: LoginFormValues) {
        try {
            await login(values.email, values.password)
        } catch {
            // Error is handled by useAuth hook
        }
    }

    return (
        <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 p-4">
            <Card className="w-full max-w-md shadow-lg border-0 bg-white/95 backdrop-blur supports-[backdrop-filter]:bg-white/60 dark:bg-zinc-900/95">
                <CardHeader className="space-y-1">
                    <CardTitle className="text-2xl font-bold tracking-tight text-center">Bienvenido a QFlow Pro</CardTitle>
                    <CardDescription className="text-center">
                        Ingresa tus credenciales para acceder al panel de administración
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <Form {...form}>
                        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
                            <FormField
                                control={form.control}
                                name="email"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Correo Electrónico</FormLabel>
                                        <FormControl>
                                            <Input placeholder="tu@empresa.com" {...field} />
                                        </FormControl>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                            <FormField
                                control={form.control}
                                name="password"
                                render={({ field }) => (
                                    <FormItem>
                                        <div className="flex items-center justify-between">
                                            <FormLabel>Contraseña</FormLabel>
                                            <Link
                                                href="/auth/forgot-password"
                                                className="text-sm font-medium text-muted-foreground hover:underline"
                                            >
                                                ¿Olvidaste tu contraseña?
                                            </Link>
                                        </div>
                                        <FormControl>
                                            <Input type="password" placeholder="••••••" {...field} />
                                        </FormControl>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                            {error && (
                                <div className="text-sm font-medium text-destructive text-center">
                                    {error}
                                </div>
                            )}
                            <Button className="w-full" type="submit" disabled={isLoading}>
                                {isLoading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                                Iniciar Sesión
                            </Button>
                        </form>
                    </Form>
                </CardContent>
                <CardFooter className="flex flex-col space-y-4">
                    <div className="text-sm text-muted-foreground text-center">
                        Don&apos;t have an account?{" "}
                        <Link href="/auth/register" className="text-primary underline-offset-4 hover:underline">
                            Sign up
                        </Link>
                    </div>
                </CardFooter>
            </Card>
        </div>
    )
}
