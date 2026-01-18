"use client"

import { useState } from "react"
import Link from "next/link"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from "zod"
import { Loader2, Store, ArrowLeft, Mail, AlertCircle } from "lucide-react"

import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Alert, AlertDescription } from "@/components/ui/alert"
import { useAuth } from "@/hooks/use-auth"

const forgotPasswordSchema = z.object({
    email: z.string().email("Por favor ingresa un correo válido"),
})

type ForgotPasswordFormValues = z.infer<typeof forgotPasswordSchema>

export default function ForgotPasswordPage() {
    const { forgotPassword, isLoading, error: authError } = useAuth()
    const [isSubmitted, setIsSubmitted] = useState(false)

    const {
        register,
        handleSubmit,
        formState: { errors },
    } = useForm<ForgotPasswordFormValues>({
        resolver: zodResolver(forgotPasswordSchema),
        defaultValues: {
            email: "",
        },
    })

    async function onSubmit(data: ForgotPasswordFormValues) {
        try {
            await forgotPassword(data.email)
            setIsSubmitted(true)
        } catch {
            // Error is handled by useAuth
        }
    }

    if (isSubmitted) {
        return (
            <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
                <Card className="w-full max-w-md">
                    <CardHeader>
                        <div className="flex justify-center mb-4">
                            <div className="h-12 w-12 rounded-full bg-green-100 flex items-center justify-center">
                                <Mail className="h-6 w-6 text-green-600" />
                            </div>
                        </div>
                        <CardTitle className="text-center text-2xl">¡Correo Enviado!</CardTitle>
                        <CardDescription className="text-center">
                            Te hemos enviado un enlace para restablecer tu contraseña. Por favor revisa tu bandeja de entrada.
                        </CardDescription>
                    </CardHeader>
                    <CardFooter className="flex justify-center">
                        <Link href="/auth/login">
                            <Button variant="outline" className="w-full">
                                <ArrowLeft className="mr-2 h-4 w-4" />
                                Volver al Inicio de Sesión
                            </Button>
                        </Link>
                    </CardFooter>
                </Card>
            </div>
        )
    }

    return (
        <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
            <Card className="w-full max-w-md">
                <CardHeader className="space-y-1">
                    <div className="flex items-center justify-center mb-4">
                        <div className="h-10 w-10 rounded-lg bg-primary flex items-center justify-center">
                            <Store className="h-6 w-6 text-primary-foreground" />
                        </div>
                    </div>
                    <CardTitle className="text-2xl font-bold text-center">Recuperar Contraseña</CardTitle>
                    <CardDescription className="text-center">
                        Ingresa tu correo y te enviaremos instrucciones
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
                        <div className="space-y-2">
                            <Label htmlFor="email">Correo Electrónico</Label>
                            <Input
                                id="email"
                                type="email"
                                placeholder="tu@empresa.com"
                                {...register("email")}
                                disabled={isLoading}
                            />
                            {errors.email && (
                                <p className="text-sm text-destructive">{errors.email.message}</p>
                            )}
                        </div>

                        {authError && (
                            <Alert variant="destructive">
                                <AlertCircle className="h-4 w-4" />
                                <AlertDescription>{authError}</AlertDescription>
                            </Alert>
                        )}

                        <Button className="w-full" type="submit" disabled={isLoading}>
                            {isLoading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                            Enviar enlace de recuperación
                        </Button>
                    </form>
                </CardContent>
                <CardFooter className="flex justify-center">
                    <Link
                        href="/auth/login"
                        className="flex items-center text-sm text-muted-foreground hover:text-primary transition-colors"
                    >
                        <ArrowLeft className="mr-2 h-4 w-4" />
                        Volver al Inicio de Sesión
                    </Link>
                </CardFooter>
            </Card>
        </div>
    )
}
