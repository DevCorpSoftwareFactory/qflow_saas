
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
    FormDescription,
} from '@/components/ui/form';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { toast } from 'sonner';

const documentSchema = z.object({
    invoicePrefix: z.string().optional(),
    invoiceNumber: z.number().min(1),
    resolutionText: z.string().optional(),
    posPrefix: z.string().optional(),
    posNumber: z.number().min(1),
});

export default function BillingSettingsPage() {
    const [isLoading, setIsLoading] = useState(true);

    const form = useForm<z.infer<typeof documentSchema>>({
        resolver: zodResolver(documentSchema),
        defaultValues: {
            invoicePrefix: '',
            invoiceNumber: 1,
            resolutionText: '',
            posPrefix: '',
            posNumber: 1,
        },
    });

    useEffect(() => {
        const fetchSettings = async () => {
            try {
                const settings = await SettingsService.getDocumentSettings();
                form.reset({
                    invoicePrefix: settings.invoice?.prefix || 'INV',
                    invoiceNumber: settings.invoice?.currentNumber || 1,
                    resolutionText: settings.invoice?.resolutionText || '',
                    posPrefix: settings.posTicket?.prefix || 'POS',
                    posNumber: settings.posTicket?.currentNumber || 1,
                });
            } catch (error) {
                toast.error('Failed to load billing settings');
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchSettings();
    }, [form]);

    async function onSubmit(values: z.infer<typeof documentSchema>) {
        try {
            const dto = {
                invoice: {
                    prefix: values.invoicePrefix || 'INV',
                    currentNumber: values.invoiceNumber,
                    resolutionText: values.resolutionText,
                },
                posTicket: {
                    prefix: values.posPrefix || 'POS',
                    currentNumber: values.posNumber,
                }
            };
            await SettingsService.updateDocumentSettings(dto);
            toast.success('Billing settings updated');
        } catch (error) {
            toast.error('Failed to update settings');
            console.error(error);
        }
    }

    if (isLoading) return <div className="p-8">Loading settings...</div>;

    return (
        <div className="space-y-6">
            <div>
                <h3 className="text-lg font-medium">Billing & Documents</h3>
                <p className="text-sm text-muted-foreground">
                    Configure document numbering and resolution details.
                </p>
            </div>
            <Separator />
            <Form {...form}>
                <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                    <Card>
                        <CardHeader>
                            <CardTitle>Electronic Invoice (Factura Electrónica)</CardTitle>
                            <CardDescription>DIAN Resolution and numbering.</CardDescription>
                        </CardHeader>
                        <CardContent className="grid gap-4">
                            <FormField
                                control={form.control}
                                name="resolutionText"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Resolution Text</FormLabel>
                                        <FormControl><Input placeholder="Res. No. 1876... from 2023-01-01 to 2024-01-01 ranges..." {...field} /></FormControl>
                                        <FormDescription>Legal text to display on invoices.</FormDescription>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                            <div className="grid grid-cols-2 gap-4">
                                <FormField
                                    control={form.control}
                                    name="invoicePrefix"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Prefix</FormLabel>
                                            <FormControl><Input placeholder="SETT" {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="invoiceNumber"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Current Number</FormLabel>
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
                            </div>
                        </CardContent>
                    </Card>

                    <Card>
                        <CardHeader>
                            <CardTitle>POS Ticket</CardTitle>
                            <CardDescription>Numbering for POS system.</CardDescription>
                        </CardHeader>
                        <CardContent className="grid gap-4">
                            <div className="grid grid-cols-2 gap-4">
                                <FormField
                                    control={form.control}
                                    name="posPrefix"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Prefix</FormLabel>
                                            <FormControl><Input placeholder="POS" {...field} /></FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="posNumber"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel>Current Number</FormLabel>
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
                            </div>
                        </CardContent>
                    </Card>

                    <Button type="submit">Save Changes</Button>
                </form>
            </Form>
        </div>
    );
}
