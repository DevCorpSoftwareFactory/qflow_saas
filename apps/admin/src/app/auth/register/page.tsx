"use client"

import { useState } from "react"
import Link from "next/link"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from "zod"
import { Loader2, Store, AlertCircle } from "lucide-react"

import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { useAuth } from "@/hooks/use-auth"
import { Alert, AlertDescription } from "@/components/ui/alert"

const registerSchema = z.object({
    firstName: z.string().min(2, "El nombre debe tener al menos 2 caracteres"),
    lastName: z.string().min(2, "El apellido debe tener al menos 2 caracteres"),
    email: z.string().email("Por favor ingresa un correo válido"),
    password: z.string().min(8, "La contraseña debe tener al menos 8 caracteres"),
    confirmPassword: z.string(),
}).refine((data) => data.password === data.confirmPassword, {
    message: "Las contraseñas no coinciden",
    path: ["confirmPassword"],
})

type RegisterFormValues = z.infer<typeof registerSchema>

// Temporary constants for development verification
const DEFAULT_TENANT_ID = "c0949bf7-2163-4dc2-af3a-886280e65c4a";
const DEFAULT_ROLE_ID = "bc9c3ee1-ca72-4dd3-b803-a257269af12a";

export default function RegisterPage() {
    const { register: registerUser, isLoading, error: authError } = useAuth()
    const [success, setSuccess] = useState(false)

    const {
        register,
        handleSubmit,
        formState: { errors },
    } = useForm<RegisterFormValues>({
        resolver: zodResolver(registerSchema),
        defaultValues: {
            firstName: "",
            lastName: "",
            email: "",
            password: "",
            confirmPassword: "",
        },
    })

    async function onSubmit(data: RegisterFormValues) {
        try {
            await registerUser({
                fullName: `${data.firstName} ${data.lastName}`,
                email: data.email,
                password: data.password,
                tenantId: DEFAULT_TENANT_ID,
                roleId: DEFAULT_ROLE_ID,
            })
            setSuccess(true)
        } catch {
            // Error is handled by useAuth hook
        }
    }

    if (success) {
        return (
            <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
                <Card className="w-full max-w-md">
                    <CardHeader>
                        <div className="flex justify-center mb-4">
                            <div className="h-12 w-12 rounded-full bg-green-100 flex items-center justify-center">
                                <Store className="h-6 w-6 text-green-600" />
                            </div>
                        </div>
                        <CardTitle className="text-center text-2xl">¡Cuenta Creada!</CardTitle>
                        <CardDescription className="text-center">
                            Tu cuenta ha sido creada exitosamente. Por favor verifica tu correo para continuar.
                        </CardDescription>
                    </CardHeader>
                    <CardFooter className="flex justify-center">
                        <Link href="/auth/login">
                            <Button>Ir al Inicio de Sesión</Button>
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
                    <CardTitle className="text-2xl font-bold text-center">Crear una cuenta</CardTitle>
                    <CardDescription className="text-center">
                        Ingresa tus datos para comenzar con QFlow Pro
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
                        <div className="grid grid-cols-2 gap-4">
                            <div className="space-y-2">
                                <Label htmlFor="firstName">Nombre</Label>
                                <Input id="firstName" placeholder="Juan" {...register("firstName")} disabled={isLoading} />
                                {errors.firstName && <p className="text-sm text-destructive">{errors.firstName.message}</p>}
                            </div>
                            <div className="space-y-2">
                                <Label htmlFor="lastName">Apellido</Label>
                                <Input id="lastName" placeholder="Pérez" {...register("lastName")} disabled={isLoading} />
                                {errors.lastName && <p className="text-sm text-destructive">{errors.lastName.message}</p>}
                            </div>
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="email">Correo Electrónico</Label>
                            <Input id="email" type="email" placeholder="juan@ejemplo.com" {...register("email")} disabled={isLoading} />
                            {errors.email && <p className="text-sm text-destructive">{errors.email.message}</p>}
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="password">Contraseña</Label>
                            <Input id="password" type="password" {...register("password")} disabled={isLoading} />
                            {errors.password && <p className="text-sm text-destructive">{errors.password.message}</p>}
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="confirmPassword">Confirmar Contraseña</Label>
                            <Input id="confirmPassword" type="password" {...register("confirmPassword")} disabled={isLoading} />
                            {errors.confirmPassword && <p className="text-sm text-destructive">{errors.confirmPassword.message}</p>}
                        </div>

                        {authError && (
                            <Alert variant="destructive">
                                <AlertCircle className="h-4 w-4" />
                                <AlertDescription>{authError}</AlertDescription>
                            </Alert>
                        )}
                        <Button className="w-full" type="submit" disabled={isLoading}>
                            {isLoading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                            Registrarse
                        </Button>
                    </form>
                </CardContent>
                <CardFooter className="flex justify-center text-sm text-muted-foreground">
                    ¿Ya tienes una cuenta?{" "}
                    <Link href="/auth/login" className="ml-1 underline underline-offset-4 hover:text-primary transition-colors font-medium">
                        Inicia Sesión
                    </Link>
                </CardFooter>
            </Card>
        </div>
    )
}
