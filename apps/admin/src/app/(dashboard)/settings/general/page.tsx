
'use client';

import { useState, useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { SettingsService } from '@/services/settings.service';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Separator } from '@/components/ui/separator';
import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from '@/components/ui/form';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { toast } from 'sonner';

const companySchema = z.object({
    name: z.string().min(2, 'Company name is required'),
    nit: z.string().min(2, 'Tax ID/NIT is required'),
    address: z.string().optional(),
    phone: z.string().optional(),
    email: z.string().email(),
    website: z.string().url().optional().or(z.literal('')),
    primaryColor: z.string().regex(/^#[0-9A-F]{6}$/i, 'Invalid hex color').optional().or(z.literal('')),
    language: z.string().optional(),
    timezone: z.string().optional(),
    currency: z.string().optional(),
});

export default function GeneralSettingsPage() {
    const [isLoading, setIsLoading] = useState(true);

    const form = useForm<z.infer<typeof companySchema>>({
        resolver: zodResolver(companySchema),
        defaultValues: {
            name: '',
            nit: '',
            address: '',
            phone: '',
            email: '',
            website: '',
            primaryColor: '',
            language: 'es',
            timezone: 'America/Bogota',
            currency: 'COP',
        },
    });

    useEffect(() => {
        const fetchSettings = async () => {
            try {
                const settings = await SettingsService.getCompanySettings();
                form.reset({
                    name: settings.name,
                    nit: settings.nit,
                    address: settings.address || '',
                    phone: settings.phone || '',
                    email: settings.email,
                    website: settings.website || '',
                    primaryColor: settings.primaryColor || '',
                    language: 'es', // settings.language, mocked for now if missing
                    timezone: settings.timezone,
                    currency: settings.currency,
                });
            } catch (error) {
                toast.error('Failed to load company settings');
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchSettings();
    }, [form]);

    async function onSubmit(values: z.infer<typeof companySchema>) {
        try {
            await SettingsService.updateCompanySettings(values);
            toast.success('Company settings updated');
        } catch (error) {
            toast.error('Failed to update settings');
            console.error(error);
        }
    }

    if (isLoading) return <div className="p-8">Loading settings...</div>;

    return (
        <div className="space-y-6">
            <div>
                <h3 className="text-lg font-medium">General Settings</h3>
                <p className="text-sm text-muted-foreground">
                    Manage your company information, branding, and regional preferences.
                </p>
            </div>
            <Separator />
            <Form {...form}>
                <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                    <Card>
                        <CardHeader>
                            <CardTitle>Company Information</CardTitle>
                            <CardDescription>Legal and contact details.</CardDescription>
                        </CardHeader>
                        <CardContent className="grid gap-4">
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <FormField
                                    control={form.control}
                                    name="name"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Company Name</FormLabel>
                                            <FormControl><Input {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="nit"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Tax ID (NIT)</FormLabel>
                                            <FormControl><Input {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <FormField
                                control={form.control}
                                name="address"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Address</FormLabel>
                                        <FormControl><Input {...field} /></FormControl>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <FormField
                                    control={form.control}
                                    name="phone"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Phone</FormLabel>
                                            <FormControl><Input {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="email"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Email</FormLabel>
                                            <FormControl><Input {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <FormField
                                control={form.control}
                                name="website"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Website</FormLabel>
                                        <FormControl><Input {...field} /></FormControl>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                        </CardContent>
                    </Card>

                    <Card>
                        <CardHeader>
                            <CardTitle>Branding & Regional</CardTitle>
                            <CardDescription>Customize appearance and formats.</CardDescription>
                        </CardHeader>
                        <CardContent className="grid gap-4">
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <FormField
                                    control={form.control}
                                    name="primaryColor"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Primary Color (Hex)</FormLabel>
                                            <FormControl>
                                                <div className="flex gap-2">
                                                    <div
                                                        className="w-10 h-10 rounded border shrink-0"
                                                        style={{ backgroundColor: field.value || '#ffffff' }}
                                                    />
                                                    <Input {...field} placeholder="#FF5733" />
                                                </div>
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <FormField
                                    control={form.control}
                                    name="currency"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Currency</FormLabel>
                                            <FormControl><Input {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="language"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Language</FormLabel>
                                            <FormControl><Input {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="timezone"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Timezone</FormLabel>
                                            <FormControl><Input {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>
                        </CardContent>
                    </Card>

                    <Button type="submit">Save Changes</Button>
                </form>
            </Form>
        </div>
    );
}
