
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
    FormDescription,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from '@/components/ui/form';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { toast } from 'sonner';

const securitySchema = z.object({
    sessionTimeoutMinutes: z.number().min(5),
    minPasswordLength: z.number().min(6),
    passwordExpiryDays: z.number().min(0),
    maxLoginAttempts: z.number().min(1),
});

export default function SecuritySettingsPage() {
    const [isLoading, setIsLoading] = useState(true);

    const form = useForm<z.infer<typeof securitySchema>>({
        resolver: zodResolver(securitySchema),
        defaultValues: {
            sessionTimeoutMinutes: 30,
            minPasswordLength: 8,
            passwordExpiryDays: 90,
            maxLoginAttempts: 5,
        },
    });

    useEffect(() => {
        const fetchSettings = async () => {
            try {
                const settings = await SettingsService.getSecuritySettings();
                form.reset({
                    sessionTimeoutMinutes: settings.sessionTimeoutMinutes || 30,
                    minPasswordLength: settings.minPasswordLength || 8,
                    passwordExpiryDays: settings.passwordExpiryDays || 90,
                    maxLoginAttempts: settings.maxLoginAttempts || 5,
                });
            } catch (error) {
                toast.error('Failed to load security settings');
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchSettings();
    }, [form]);

    async function onSubmit(values: z.infer<typeof securitySchema>) {
        try {
            await SettingsService.updateSecuritySettings(values);
            toast.success('Security settings updated');
        } catch (error) {
            toast.error('Failed to update settings');
            console.error(error);
        }
    }

    if (isLoading) return <div className="p-8">Loading settings...</div>;

    return (
        <div className="space-y-6">
            <div>
                <h3 className="text-lg font-medium">Security Policies</h3>
                <p className="text-sm text-muted-foreground">
                    Configure security thresholds and password policies.
                </p>
            </div>
            <Separator />
            <Form {...form}>
                <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                    <Card>
                        <CardHeader>
                            <CardTitle>Session & Access</CardTitle>
                        </CardHeader>
                        <CardContent className="grid md:grid-cols-2 gap-4">
                            <FormField
                                control={form.control}
                                name="sessionTimeoutMinutes"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Session Timeout (Minutes)</FormLabel>
                                        <FormControl>
                                            <Input
                                                type="number"
                                                {...field}
                                                onChange={e => field.onChange(parseInt(e.target.value) || 0)}
                                            />
                                        </FormControl>
                                        <FormDescription>Auto-logout after inactivity.</FormDescription>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                            <FormField
                                control={form.control}
                                name="maxLoginAttempts"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Max Login Attempts</FormLabel>
                                        <FormControl>
                                            <Input
                                                type="number"
                                                {...field}
                                                onChange={e => field.onChange(parseInt(e.target.value) || 0)}
                                            />
                                        </FormControl>
                                        <FormDescription>Lock account after failed attempts.</FormDescription>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                        </CardContent>
                    </Card>

                    <Card>
                        <CardHeader>
                            <CardTitle>Password Policy</CardTitle>
                        </CardHeader>
                        <CardContent className="grid md:grid-cols-2 gap-4">
                            <FormField
                                control={form.control}
                                name="minPasswordLength"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Minimum Length</FormLabel>
                                        <FormControl>
                                            <Input
                                                type="number"
                                                {...field}
                                                onChange={e => field.onChange(parseInt(e.target.value) || 0)}
                                            />
                                        </FormControl>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                            <FormField
                                control={form.control}
                                name="passwordExpiryDays"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Password Expiry (Days)</FormLabel>
                                        <FormControl>
                                            <Input
                                                type="number"
                                                {...field}
                                                onChange={e => field.onChange(parseInt(e.target.value) || 0)}
                                            />
                                        </FormControl>
                                        <FormDescription>Force reset after days (0 to disable).</FormDescription>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                        </CardContent>
                    </Card>
                    <Button type="submit">Save Changes</Button>
                </form>
            </Form>
        </div>
    );
}
