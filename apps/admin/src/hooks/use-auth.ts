import { useAuth as useAuthContext } from '@/contexts/auth-context';

export function useAuth() {
    const context = useAuthContext();
    return {
        user: context.user,
        loading: context.loading,
        isLoading: context.isLoading,
        error: context.error,
        login: context.login,
        register: context.register,
        forgotPassword: context.forgotPassword,
        logout: context.logout,
        fetchProfile: context.fetchProfile,
        updateProfile: context.updateProfile,
        clearError: context.clearError,
    };
}
