import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_color.dart';
import '../service/smart_routing_service.dart';

class OfflineMapsScreen extends ConsumerStatefulWidget {
  const OfflineMapsScreen({super.key});

  @override
  ConsumerState<OfflineMapsScreen> createState() => _OfflineMapsScreenState();
}

class _OfflineMapsScreenState extends ConsumerState<OfflineMapsScreen> {
  final _routingService = SmartRoutingService();
  List<String> _availableRegions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRegions();
  }

  Future<void> _loadRegions() async {
    setState(() => _isLoading = true);
    try {
      await _routingService.initialize();
      final regions = await _routingService.getAvailableOfflineRegions();
      setState(() {
        _availableRegions = regions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading regions: $e')),
        );
      }
    }
  }

  Future<void> _downloadRegion(String regionName, double minLat, double maxLat, double minLon, double maxLon) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Downloading map data...'),
            Text('This may take several minutes', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );

    try {
      await _routingService.downloadRegion(
        regionName: regionName,
        minLat: minLat,
        maxLat: maxLat,
        minLon: minLon,
        maxLon: maxLon,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$regionName downloaded successfully!')),
        );
        await _loadRegions();
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error downloading region: $e')),
        );
      }
    }
  }

  Future<void> _deleteRegion(String regionId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Region'),
        content: const Text('Are you sure you want to delete this offline map?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _routingService.deleteOfflineRegion(regionId);
      await _loadRegions();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Region deleted')),
        );
      }
    }
  }

  void _showDownloadDialog() {
    final regions = [
      {'name': 'Dubai Marina', 'minLat': 25.07, 'maxLat': 25.09, 'minLon': 55.12, 'maxLon': 55.15},
      {'name': 'Downtown Dubai', 'minLat': 25.19, 'maxLat': 25.21, 'minLon': 55.27, 'maxLon': 55.29},
      {'name': 'Dubai Mall Area', 'minLat': 25.19, 'maxLat': 25.22, 'minLon': 55.26, 'maxLon': 55.29},
      {'name': 'Business Bay', 'minLat': 25.18, 'maxLat': 25.20, 'minLon': 55.25, 'maxLon': 55.27},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Region'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: regions.length,
            itemBuilder: (context, index) {
              final region = regions[index];
              return ListTile(
                leading: const Icon(Icons.map),
                title: Text(region['name'] as String),
                subtitle: const Text('~2-5 MB'),
                trailing: const Icon(Icons.download),
                onTap: () {
                  Navigator.pop(context);
                  _downloadRegion(
                    region['name'] as String,
                    region['minLat'] as double,
                    region['maxLat'] as double,
                    region['minLon'] as double,
                    region['maxLon'] as double,
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Maps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadRegions,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.primary.withOpacity(0.1),
                  child: Row(
                    children: [
                      Icon(
                        _routingService.hasOfflineNetwork ? Icons.check_circle : Icons.info,
                        color: _routingService.hasOfflineNetwork ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _routingService.hasOfflineNetwork
                              ? 'Offline routing is available'
                              : 'Download a region for offline routing',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _availableRegions.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.map_outlined, size: 64, color: Colors.grey),
                              const SizedBox(height: 16),
                              const Text(
                                'No offline maps downloaded',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Download regions to use offline routing',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: _showDownloadDialog,
                                icon: const Icon(Icons.download),
                                label: const Text('Download Region'),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _availableRegions.length,
                          itemBuilder: (context, index) {
                            final regionId = _availableRegions[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.map),
                                ),
                                title: Text(regionId),
                                subtitle: const Text('Offline map data available'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteRegion(regionId),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDownloadDialog,
        icon: const Icon(Icons.add),
        label: const Text('Download Region'),
      ),
    );
  }

  @override
  void dispose() {
    _routingService.dispose();
    super.dispose();
  }
}
