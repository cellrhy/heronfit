import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heronfit/core/router/app_routes.dart';
import 'package:heronfit/features/progress/models/progress_record.dart';
import 'package:intl/intl.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:heronfit/core/theme.dart';

class ProgressPhotoListItem extends StatelessWidget {
  final ProgressRecord record;
  final int index; // Index needed for navigation to the correct initial photo

  const ProgressPhotoListItem({
    required this.record,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: HeronFitTheme.cardShadow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Consistent rounding
        ),
        elevation: 0, // Subtle elevation
        margin: const EdgeInsets.only(bottom: 12), // Spacing between items
        child: InkWell(
          onTap: () {
            // Navigate to the single photo view, passing the index
            context.push(AppRoutes.progressViewPhoto, extra: index);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.primaryColor,
                      width: 2, // Increased border width to 4
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      record.photoUrl!,
                      width: 64, // Adjusted size
                      height: 64,
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (context, child, progress) =>
                              progress == null
                                  ? child
                                  : Container(
                                    width: 64,
                                    height: 64,
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                      errorBuilder:
                          (context, error, stack) => Container(
                            width: 64,
                            height: 64,
                            color: Colors.grey[300],
                            child: Icon(
                              SolarIconsOutline.galleryRemove,
                              color: Colors.grey[600],
                              size: 30,
                            ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat(
                          'MMMM d, yyyy',
                        ).format(record.date.toLocal()),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${record.weight.toStringAsFixed(1)} kg',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  SolarIconsOutline.altArrowRight,
                  color: theme.hintColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
