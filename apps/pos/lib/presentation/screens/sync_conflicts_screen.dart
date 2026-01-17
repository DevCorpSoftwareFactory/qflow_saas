import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/injection.dart';
import '../blocs/sync/sync_bloc.dart';

class SyncConflictsScreen extends StatelessWidget {
  const SyncConflictsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SyncBloc(getIt())..add(LoadConflicts()),
      child: const _SyncConflictsView(),
    );
  }
}

class _SyncConflictsView extends StatelessWidget {
  const _SyncConflictsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sincronización y Conflictos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<SyncBloc>().add(LoadConflicts()),
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sincronizar ahora',
            onPressed: () => context.read<SyncBloc>().add(RunSync()),
          ),
        ],
      ),
      body: BlocConsumer<SyncBloc, SyncState>(
        listener: (context, state) {
          if (state is SyncError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is SyncLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SyncLoaded) {
            return _buildContent(context, state);
          }
          return const Center(child: Text('Estado desconocido'));
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, SyncLoaded state) {
    return Column(
      children: [
        // Status Header
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('Pendientes', state.pendingCount.toString()),
              _buildStat('Conflictos', state.conflicts.length.toString(),
                  isError: state.conflicts.isNotEmpty),
            ],
          ),
        ),

        // Conflict List
        Expanded(
          child: state.conflicts.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: state.conflicts.length,
                  itemBuilder: (context, index) {
                    final conflict = state.conflicts[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ExpansionTile(
                        leading:
                            const Icon(Icons.warning, color: Colors.orange),
                        title: Text(
                            '${conflict.entityType} #${conflict.entityId}'),
                        subtitle: Text('Error: ${conflict.conflictType}'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mensaje Servidor:',
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.red.shade50,
                                  width: double.infinity,
                                  child:
                                      Text(_prettyJson(conflict.remotePayload)),
                                ),
                                const SizedBox(height: 8),
                                Text('Datos Locales:',
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.blue.shade50,
                                  width: double.infinity,
                                  child:
                                      Text(_prettyJson(conflict.localPayload)),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OutlinedButton.icon(
                                      icon: const Icon(Icons.cloud_download),
                                      label: const Text('Usar Servidor'),
                                      onPressed: () =>
                                          _resolve(context, conflict.id, false),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.upload),
                                      label: const Text('Forzar Local'),
                                      onPressed: () =>
                                          _resolve(context, conflict.id, true),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          SizedBox(height: 16),
          Text('No hay conflictos pendientes'),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, {bool isError = false}) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isError ? Colors.red : Colors.black)),
        Text(label),
      ],
    );
  }

  void _resolve(BuildContext context, int id, bool keepLocal) {
    context.read<SyncBloc>().add(ResolveConflict(id, keepLocal));
  }

  String _prettyJson(String jsonStr) {
    try {
      final object = json.decode(jsonStr);
      return const JsonEncoder.withIndent('  ').convert(object);
    } catch (e) {
      return jsonStr;
    }
  }
}
