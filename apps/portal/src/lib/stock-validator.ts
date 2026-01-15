export class StockValidator {
    private static readonly API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000';

    /**
     * Check stock availability for a variant.
     * Throws error if stock is insufficient.
     */
    static async checkAvailability(
        variantId: string,
        branchId: string,
        quantity: number
    ): Promise<boolean> {
        try {
            const response = await fetch(`${this.API_URL}/inventory/check-availability`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ variantId, branchId, quantity }),
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || 'Stock validation failed');
            }

            const data = await response.json();
            return data.available === true;
        } catch (error) {
            console.error('Stock Validation Error:', error);
            throw error;
        }
    }
}
