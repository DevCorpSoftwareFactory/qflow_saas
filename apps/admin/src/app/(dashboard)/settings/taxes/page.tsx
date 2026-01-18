
'use client';

import { useState, useEffect } from 'react';
import { useForm, useFieldArray } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { SettingsService } from '@/services/settings.service';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Separator } from '@/components/ui/separator';
import { Switch } from '@/components/ui/switch';
import {
    Form,
    FormControl,
    FormDescription,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from '@/components/ui/form';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { toast } from 'sonner';
import { Trash2, Plus } from 'lucide-react';

const taxSchema = z.object({
    taxRegime: z.string().optional(),
    pricesIncludeTax: z.boolean(),
    configuredRates: z.array(z.object({
        name: z.string().min(1, 'Name required'),
        rate: z.number().min(0, 'Rate must be positive'),
    })),
});

export default function TaxesSettingsPage() {
    const [isLoading, setIsLoading] = useState(true);

    const form = useForm<z.infer<typeof taxSchema>>({
        resolver: zodResolver(taxSchema),
        defaultValues: {
            taxRegime: 'Common',
            pricesIncludeTax: false,
            configuredRates: [],
        },
    });

    const { fields, append, remove } = useFieldArray({
        control: form.control,
        name: "configuredRates",
    });

    useEffect(() => {
        const fetchSettings = async () => {
            try {
                const settings = await SettingsService.getTaxSettings();
                form.reset({
                    taxRegime: settings.taxRegime || 'Common',
                    pricesIncludeTax: settings.pricesIncludeTax || false,
                    configuredRates: settings.configuredRates.length > 0 ? settings.configuredRates : [{ name: 'IVA 19%', rate: 19 }],
                });
            } catch (error) {
                toast.error('Failed to load tax settings');
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchSettings();
    }, [form]);

    async function onSubmit(values: z.infer<typeof taxSchema>) {
        try {
            await SettingsService.updateTaxSettings(values);
            toast.success('Tax settings updated');
        } catch (error) {
            toast.error('Failed to update settings');
            console.error(error);
        }
    }

    if (isLoading) return <div className="p-8">Loading settings...</div>;

    return (
        <div className="space-y-6">
            <div>
                <h3 className="text-lg font-medium">Tax Configuration</h3>
                <p className="text-sm text-muted-foreground">
                    Manage tax rates and regimes.
                </p>
            </div>
            <Separator />
            <Form {...form}>
                <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                    <Card>
                        <CardHeader>
                            <CardTitle>General Tax Rules</CardTitle>
                        </CardHeader>
                        <CardContent className="space-y-4">
                            <FormField
                                control={form.control}
                                name="taxRegime"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel>Tax Regime</FormLabel>
                                        <FormControl><Input placeholder="e.g., Responsable de IVA" {...field} /></FormControl>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />
                            <FormField
                                control={form.control}
                                name="pricesIncludeTax"
                                render={({ field }) => (
                                    <FormItem className="flex flex-row items-center justify-between rounded-lg border p-4">
                                        <div className="space-y-0.5">
                                            <FormLabel className="text-base">Prices Include Tax</FormLabel>
                                            <FormDescription>
                                                If enabled, product prices will be treated as tax-inclusive.
                                            </FormDescription>
                                        </div>
                                        <FormControl>
                                            <Switch
                                                checked={field.value}
                                                onCheckedChange={field.onChange}
                                            />
                                        </FormControl>
                                    </FormItem>
                                )}
                            />
                        </CardContent>
                    </Card>

                    <Card>
                        <CardHeader>
                            <CardTitle>Configured Tax Rates</CardTitle>
                            <CardDescription>Define the tax rates available for products.</CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-4">
                            {fields.map((field, index) => (
                                <div key={field.id} className="flex gap-4 items-end">
                                    <FormField
                                        control={form.control}
                                        name={`configuredRates.${index}.name`}
                                        render={({ field }) => (
                                            <FormItem className="flex-1">
                                                <FormLabel className={index !== 0 ? "sr-only" : ""}>Name</FormLabel>
                                                <FormControl><Input placeholder="IVA 19%" {...field} /></FormControl>
                                                <FormMessage />
                                            </FormItem>
                                        )}
                                    />
                                    <FormField
                                        control={form.control}
                                        name={`configuredRates.${index}.rate`}
                                        render={({ field }) => (
                                            <FormItem className="w-32">
                                                <FormLabel className={index !== 0 ? "sr-only" : ""}>Rate (%)</FormLabel>
                                                <FormControl>
                                                    <Input
                                                        type="number"
                                                        step="0.01"
                                                        {...field}
                                                        onChange={e => field.onChange(parseFloat(e.target.value) || 0)}
                                                    />
                                                </FormControl>
                                                <FormMessage />
                                            </FormItem>
                                        )}
                                    />
                                    <Button type="button" variant="destructive" size="icon" onClick={() => remove(index)}>
                                        <Trash2 className="h-4 w-4" />
                                    </Button>
                                </div>
                            ))}
                            <Button type="button" variant="outline" onClick={() => append({ name: '', rate: 0 })} className="mt-2">
                                <Plus className="mr-2 h-4 w-4" /> Add Rate
                            </Button>
                        </CardContent>
                    </Card>

                    <Button type="submit">Save Changes</Button>
                </form>
            </Form>
        </div>
    );
}
