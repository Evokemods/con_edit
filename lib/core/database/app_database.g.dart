// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FieldMetadataTableTable extends FieldMetadataTable
    with TableInfo<$FieldMetadataTableTable, FieldMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fieldPathMeta = const VerificationMeta(
    'fieldPath',
  );
  @override
  late final GeneratedColumn<String> fieldPath = GeneratedColumn<String>(
    'field_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pluginNameMeta = const VerificationMeta(
    'pluginName',
  );
  @override
  late final GeneratedColumn<String> pluginName = GeneratedColumn<String>(
    'plugin_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _configTypeMeta = const VerificationMeta(
    'configType',
  );
  @override
  late final GeneratedColumn<String> configType = GeneratedColumn<String>(
    'config_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tooltipMeta = const VerificationMeta(
    'tooltip',
  );
  @override
  late final GeneratedColumn<String> tooltip = GeneratedColumn<String>(
    'tooltip',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueTypeMeta = const VerificationMeta(
    'valueType',
  );
  @override
  late final GeneratedColumn<String> valueType = GeneratedColumn<String>(
    'value_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widgetHintMeta = const VerificationMeta(
    'widgetHint',
  );
  @override
  late final GeneratedColumn<String> widgetHint = GeneratedColumn<String>(
    'widget_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allowedValuesMeta = const VerificationMeta(
    'allowedValues',
  );
  @override
  late final GeneratedColumn<String> allowedValues = GeneratedColumn<String>(
    'allowed_values',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultValueMeta = const VerificationMeta(
    'defaultValue',
  );
  @override
  late final GeneratedColumn<String> defaultValue = GeneratedColumn<String>(
    'default_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autocompleteSourceMeta =
      const VerificationMeta('autocompleteSource');
  @override
  late final GeneratedColumn<String> autocompleteSource =
      GeneratedColumn<String>(
        'autocomplete_source',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _imagePreviewUrlMeta = const VerificationMeta(
    'imagePreviewUrl',
  );
  @override
  late final GeneratedColumn<String> imagePreviewUrl = GeneratedColumn<String>(
    'image_preview_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionalFieldMeta = const VerificationMeta(
    'conditionalField',
  );
  @override
  late final GeneratedColumn<String> conditionalField = GeneratedColumn<String>(
    'conditional_field',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _presetNameMeta = const VerificationMeta(
    'presetName',
  );
  @override
  late final GeneratedColumn<String> presetName = GeneratedColumn<String>(
    'preset_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant<double>(1.0),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('1.0.0'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldPath,
    pluginName,
    configType,
    description,
    tooltip,
    valueType,
    widgetHint,
    allowedValues,
    defaultValue,
    autocompleteSource,
    imagePreviewUrl,
    conditionalField,
    presetName,
    confidence,
    version,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'field_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<FieldMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_path')) {
      context.handle(
        _fieldPathMeta,
        fieldPath.isAcceptableOrUnknown(data['field_path']!, _fieldPathMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldPathMeta);
    }
    if (data.containsKey('plugin_name')) {
      context.handle(
        _pluginNameMeta,
        pluginName.isAcceptableOrUnknown(data['plugin_name']!, _pluginNameMeta),
      );
    }
    if (data.containsKey('config_type')) {
      context.handle(
        _configTypeMeta,
        configType.isAcceptableOrUnknown(data['config_type']!, _configTypeMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('tooltip')) {
      context.handle(
        _tooltipMeta,
        tooltip.isAcceptableOrUnknown(data['tooltip']!, _tooltipMeta),
      );
    }
    if (data.containsKey('value_type')) {
      context.handle(
        _valueTypeMeta,
        valueType.isAcceptableOrUnknown(data['value_type']!, _valueTypeMeta),
      );
    }
    if (data.containsKey('widget_hint')) {
      context.handle(
        _widgetHintMeta,
        widgetHint.isAcceptableOrUnknown(data['widget_hint']!, _widgetHintMeta),
      );
    }
    if (data.containsKey('allowed_values')) {
      context.handle(
        _allowedValuesMeta,
        allowedValues.isAcceptableOrUnknown(
          data['allowed_values']!,
          _allowedValuesMeta,
        ),
      );
    }
    if (data.containsKey('default_value')) {
      context.handle(
        _defaultValueMeta,
        defaultValue.isAcceptableOrUnknown(
          data['default_value']!,
          _defaultValueMeta,
        ),
      );
    }
    if (data.containsKey('autocomplete_source')) {
      context.handle(
        _autocompleteSourceMeta,
        autocompleteSource.isAcceptableOrUnknown(
          data['autocomplete_source']!,
          _autocompleteSourceMeta,
        ),
      );
    }
    if (data.containsKey('image_preview_url')) {
      context.handle(
        _imagePreviewUrlMeta,
        imagePreviewUrl.isAcceptableOrUnknown(
          data['image_preview_url']!,
          _imagePreviewUrlMeta,
        ),
      );
    }
    if (data.containsKey('conditional_field')) {
      context.handle(
        _conditionalFieldMeta,
        conditionalField.isAcceptableOrUnknown(
          data['conditional_field']!,
          _conditionalFieldMeta,
        ),
      );
    }
    if (data.containsKey('preset_name')) {
      context.handle(
        _presetNameMeta,
        presetName.isAcceptableOrUnknown(data['preset_name']!, _presetNameMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldMetadataRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fieldPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_path'],
      )!,
      pluginName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_name'],
      ),
      configType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config_type'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      tooltip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tooltip'],
      ),
      valueType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_type'],
      ),
      widgetHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}widget_hint'],
      ),
      allowedValues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allowed_values'],
      ),
      defaultValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_value'],
      ),
      autocompleteSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}autocomplete_source'],
      ),
      imagePreviewUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_preview_url'],
      ),
      conditionalField: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conditional_field'],
      ),
      presetName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset_name'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FieldMetadataTableTable createAlias(String alias) {
    return $FieldMetadataTableTable(attachedDatabase, alias);
  }
}

class FieldMetadataRow extends DataClass
    implements Insertable<FieldMetadataRow> {
  /// Unique identifier for this metadata entry.
  final int id;

  /// The path to the field (e.g., "player.inventory.items[0].name").
  final String fieldPath;

  /// Optional plugin name this metadata is specific to.
  final String? pluginName;

  /// Optional config type (e.g., "skill", "loot_table").
  final String? configType;

  /// Human-readable description of the field.
  final String? description;

  /// Tooltip text shown on hover.
  final String? tooltip;

  /// Expected value type (stored as string enum).
  final String? valueType;

  /// Widget hint for rendering (stored as string enum).
  final String? widgetHint;

  /// Allowed values as JSON array (for enums/dropdowns).
  final String? allowedValues;

  /// Default value as JSON.
  final String? defaultValue;

  /// Autocomplete source identifier.
  final String? autocompleteSource;

  /// URL for image preview.
  final String? imagePreviewUrl;

  /// Field that this field depends on (for conditional rendering).
  final String? conditionalField;

  /// Preset/template name.
  final String? presetName;

  /// Confidence score (0.0 to 1.0) for learned metadata.
  final double confidence;

  /// Version of the metadata schema.
  final String version;

  /// When this metadata was created.
  final DateTime createdAt;

  /// When this metadata was last updated.
  final DateTime updatedAt;
  const FieldMetadataRow({
    required this.id,
    required this.fieldPath,
    this.pluginName,
    this.configType,
    this.description,
    this.tooltip,
    this.valueType,
    this.widgetHint,
    this.allowedValues,
    this.defaultValue,
    this.autocompleteSource,
    this.imagePreviewUrl,
    this.conditionalField,
    this.presetName,
    required this.confidence,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['field_path'] = Variable<String>(fieldPath);
    if (!nullToAbsent || pluginName != null) {
      map['plugin_name'] = Variable<String>(pluginName);
    }
    if (!nullToAbsent || configType != null) {
      map['config_type'] = Variable<String>(configType);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || tooltip != null) {
      map['tooltip'] = Variable<String>(tooltip);
    }
    if (!nullToAbsent || valueType != null) {
      map['value_type'] = Variable<String>(valueType);
    }
    if (!nullToAbsent || widgetHint != null) {
      map['widget_hint'] = Variable<String>(widgetHint);
    }
    if (!nullToAbsent || allowedValues != null) {
      map['allowed_values'] = Variable<String>(allowedValues);
    }
    if (!nullToAbsent || defaultValue != null) {
      map['default_value'] = Variable<String>(defaultValue);
    }
    if (!nullToAbsent || autocompleteSource != null) {
      map['autocomplete_source'] = Variable<String>(autocompleteSource);
    }
    if (!nullToAbsent || imagePreviewUrl != null) {
      map['image_preview_url'] = Variable<String>(imagePreviewUrl);
    }
    if (!nullToAbsent || conditionalField != null) {
      map['conditional_field'] = Variable<String>(conditionalField);
    }
    if (!nullToAbsent || presetName != null) {
      map['preset_name'] = Variable<String>(presetName);
    }
    map['confidence'] = Variable<double>(confidence);
    map['version'] = Variable<String>(version);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FieldMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return FieldMetadataTableCompanion(
      id: Value(id),
      fieldPath: Value(fieldPath),
      pluginName: pluginName == null && nullToAbsent
          ? const Value.absent()
          : Value(pluginName),
      configType: configType == null && nullToAbsent
          ? const Value.absent()
          : Value(configType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      tooltip: tooltip == null && nullToAbsent
          ? const Value.absent()
          : Value(tooltip),
      valueType: valueType == null && nullToAbsent
          ? const Value.absent()
          : Value(valueType),
      widgetHint: widgetHint == null && nullToAbsent
          ? const Value.absent()
          : Value(widgetHint),
      allowedValues: allowedValues == null && nullToAbsent
          ? const Value.absent()
          : Value(allowedValues),
      defaultValue: defaultValue == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultValue),
      autocompleteSource: autocompleteSource == null && nullToAbsent
          ? const Value.absent()
          : Value(autocompleteSource),
      imagePreviewUrl: imagePreviewUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePreviewUrl),
      conditionalField: conditionalField == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionalField),
      presetName: presetName == null && nullToAbsent
          ? const Value.absent()
          : Value(presetName),
      confidence: Value(confidence),
      version: Value(version),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FieldMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldMetadataRow(
      id: serializer.fromJson<int>(json['id']),
      fieldPath: serializer.fromJson<String>(json['fieldPath']),
      pluginName: serializer.fromJson<String?>(json['pluginName']),
      configType: serializer.fromJson<String?>(json['configType']),
      description: serializer.fromJson<String?>(json['description']),
      tooltip: serializer.fromJson<String?>(json['tooltip']),
      valueType: serializer.fromJson<String?>(json['valueType']),
      widgetHint: serializer.fromJson<String?>(json['widgetHint']),
      allowedValues: serializer.fromJson<String?>(json['allowedValues']),
      defaultValue: serializer.fromJson<String?>(json['defaultValue']),
      autocompleteSource: serializer.fromJson<String?>(
        json['autocompleteSource'],
      ),
      imagePreviewUrl: serializer.fromJson<String?>(json['imagePreviewUrl']),
      conditionalField: serializer.fromJson<String?>(json['conditionalField']),
      presetName: serializer.fromJson<String?>(json['presetName']),
      confidence: serializer.fromJson<double>(json['confidence']),
      version: serializer.fromJson<String>(json['version']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fieldPath': serializer.toJson<String>(fieldPath),
      'pluginName': serializer.toJson<String?>(pluginName),
      'configType': serializer.toJson<String?>(configType),
      'description': serializer.toJson<String?>(description),
      'tooltip': serializer.toJson<String?>(tooltip),
      'valueType': serializer.toJson<String?>(valueType),
      'widgetHint': serializer.toJson<String?>(widgetHint),
      'allowedValues': serializer.toJson<String?>(allowedValues),
      'defaultValue': serializer.toJson<String?>(defaultValue),
      'autocompleteSource': serializer.toJson<String?>(autocompleteSource),
      'imagePreviewUrl': serializer.toJson<String?>(imagePreviewUrl),
      'conditionalField': serializer.toJson<String?>(conditionalField),
      'presetName': serializer.toJson<String?>(presetName),
      'confidence': serializer.toJson<double>(confidence),
      'version': serializer.toJson<String>(version),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FieldMetadataRow copyWith({
    int? id,
    String? fieldPath,
    Value<String?> pluginName = const Value.absent(),
    Value<String?> configType = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> tooltip = const Value.absent(),
    Value<String?> valueType = const Value.absent(),
    Value<String?> widgetHint = const Value.absent(),
    Value<String?> allowedValues = const Value.absent(),
    Value<String?> defaultValue = const Value.absent(),
    Value<String?> autocompleteSource = const Value.absent(),
    Value<String?> imagePreviewUrl = const Value.absent(),
    Value<String?> conditionalField = const Value.absent(),
    Value<String?> presetName = const Value.absent(),
    double? confidence,
    String? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FieldMetadataRow(
    id: id ?? this.id,
    fieldPath: fieldPath ?? this.fieldPath,
    pluginName: pluginName.present ? pluginName.value : this.pluginName,
    configType: configType.present ? configType.value : this.configType,
    description: description.present ? description.value : this.description,
    tooltip: tooltip.present ? tooltip.value : this.tooltip,
    valueType: valueType.present ? valueType.value : this.valueType,
    widgetHint: widgetHint.present ? widgetHint.value : this.widgetHint,
    allowedValues: allowedValues.present
        ? allowedValues.value
        : this.allowedValues,
    defaultValue: defaultValue.present ? defaultValue.value : this.defaultValue,
    autocompleteSource: autocompleteSource.present
        ? autocompleteSource.value
        : this.autocompleteSource,
    imagePreviewUrl: imagePreviewUrl.present
        ? imagePreviewUrl.value
        : this.imagePreviewUrl,
    conditionalField: conditionalField.present
        ? conditionalField.value
        : this.conditionalField,
    presetName: presetName.present ? presetName.value : this.presetName,
    confidence: confidence ?? this.confidence,
    version: version ?? this.version,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FieldMetadataRow copyWithCompanion(FieldMetadataTableCompanion data) {
    return FieldMetadataRow(
      id: data.id.present ? data.id.value : this.id,
      fieldPath: data.fieldPath.present ? data.fieldPath.value : this.fieldPath,
      pluginName: data.pluginName.present
          ? data.pluginName.value
          : this.pluginName,
      configType: data.configType.present
          ? data.configType.value
          : this.configType,
      description: data.description.present
          ? data.description.value
          : this.description,
      tooltip: data.tooltip.present ? data.tooltip.value : this.tooltip,
      valueType: data.valueType.present ? data.valueType.value : this.valueType,
      widgetHint: data.widgetHint.present
          ? data.widgetHint.value
          : this.widgetHint,
      allowedValues: data.allowedValues.present
          ? data.allowedValues.value
          : this.allowedValues,
      defaultValue: data.defaultValue.present
          ? data.defaultValue.value
          : this.defaultValue,
      autocompleteSource: data.autocompleteSource.present
          ? data.autocompleteSource.value
          : this.autocompleteSource,
      imagePreviewUrl: data.imagePreviewUrl.present
          ? data.imagePreviewUrl.value
          : this.imagePreviewUrl,
      conditionalField: data.conditionalField.present
          ? data.conditionalField.value
          : this.conditionalField,
      presetName: data.presetName.present
          ? data.presetName.value
          : this.presetName,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FieldMetadataRow(')
          ..write('id: $id, ')
          ..write('fieldPath: $fieldPath, ')
          ..write('pluginName: $pluginName, ')
          ..write('configType: $configType, ')
          ..write('description: $description, ')
          ..write('tooltip: $tooltip, ')
          ..write('valueType: $valueType, ')
          ..write('widgetHint: $widgetHint, ')
          ..write('allowedValues: $allowedValues, ')
          ..write('defaultValue: $defaultValue, ')
          ..write('autocompleteSource: $autocompleteSource, ')
          ..write('imagePreviewUrl: $imagePreviewUrl, ')
          ..write('conditionalField: $conditionalField, ')
          ..write('presetName: $presetName, ')
          ..write('confidence: $confidence, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fieldPath,
    pluginName,
    configType,
    description,
    tooltip,
    valueType,
    widgetHint,
    allowedValues,
    defaultValue,
    autocompleteSource,
    imagePreviewUrl,
    conditionalField,
    presetName,
    confidence,
    version,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FieldMetadataRow &&
          other.id == this.id &&
          other.fieldPath == this.fieldPath &&
          other.pluginName == this.pluginName &&
          other.configType == this.configType &&
          other.description == this.description &&
          other.tooltip == this.tooltip &&
          other.valueType == this.valueType &&
          other.widgetHint == this.widgetHint &&
          other.allowedValues == this.allowedValues &&
          other.defaultValue == this.defaultValue &&
          other.autocompleteSource == this.autocompleteSource &&
          other.imagePreviewUrl == this.imagePreviewUrl &&
          other.conditionalField == this.conditionalField &&
          other.presetName == this.presetName &&
          other.confidence == this.confidence &&
          other.version == this.version &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FieldMetadataTableCompanion extends UpdateCompanion<FieldMetadataRow> {
  final Value<int> id;
  final Value<String> fieldPath;
  final Value<String?> pluginName;
  final Value<String?> configType;
  final Value<String?> description;
  final Value<String?> tooltip;
  final Value<String?> valueType;
  final Value<String?> widgetHint;
  final Value<String?> allowedValues;
  final Value<String?> defaultValue;
  final Value<String?> autocompleteSource;
  final Value<String?> imagePreviewUrl;
  final Value<String?> conditionalField;
  final Value<String?> presetName;
  final Value<double> confidence;
  final Value<String> version;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FieldMetadataTableCompanion({
    this.id = const Value.absent(),
    this.fieldPath = const Value.absent(),
    this.pluginName = const Value.absent(),
    this.configType = const Value.absent(),
    this.description = const Value.absent(),
    this.tooltip = const Value.absent(),
    this.valueType = const Value.absent(),
    this.widgetHint = const Value.absent(),
    this.allowedValues = const Value.absent(),
    this.defaultValue = const Value.absent(),
    this.autocompleteSource = const Value.absent(),
    this.imagePreviewUrl = const Value.absent(),
    this.conditionalField = const Value.absent(),
    this.presetName = const Value.absent(),
    this.confidence = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FieldMetadataTableCompanion.insert({
    this.id = const Value.absent(),
    required String fieldPath,
    this.pluginName = const Value.absent(),
    this.configType = const Value.absent(),
    this.description = const Value.absent(),
    this.tooltip = const Value.absent(),
    this.valueType = const Value.absent(),
    this.widgetHint = const Value.absent(),
    this.allowedValues = const Value.absent(),
    this.defaultValue = const Value.absent(),
    this.autocompleteSource = const Value.absent(),
    this.imagePreviewUrl = const Value.absent(),
    this.conditionalField = const Value.absent(),
    this.presetName = const Value.absent(),
    this.confidence = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : fieldPath = Value(fieldPath);
  static Insertable<FieldMetadataRow> custom({
    Expression<int>? id,
    Expression<String>? fieldPath,
    Expression<String>? pluginName,
    Expression<String>? configType,
    Expression<String>? description,
    Expression<String>? tooltip,
    Expression<String>? valueType,
    Expression<String>? widgetHint,
    Expression<String>? allowedValues,
    Expression<String>? defaultValue,
    Expression<String>? autocompleteSource,
    Expression<String>? imagePreviewUrl,
    Expression<String>? conditionalField,
    Expression<String>? presetName,
    Expression<double>? confidence,
    Expression<String>? version,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldPath != null) 'field_path': fieldPath,
      if (pluginName != null) 'plugin_name': pluginName,
      if (configType != null) 'config_type': configType,
      if (description != null) 'description': description,
      if (tooltip != null) 'tooltip': tooltip,
      if (valueType != null) 'value_type': valueType,
      if (widgetHint != null) 'widget_hint': widgetHint,
      if (allowedValues != null) 'allowed_values': allowedValues,
      if (defaultValue != null) 'default_value': defaultValue,
      if (autocompleteSource != null) 'autocomplete_source': autocompleteSource,
      if (imagePreviewUrl != null) 'image_preview_url': imagePreviewUrl,
      if (conditionalField != null) 'conditional_field': conditionalField,
      if (presetName != null) 'preset_name': presetName,
      if (confidence != null) 'confidence': confidence,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FieldMetadataTableCompanion copyWith({
    Value<int>? id,
    Value<String>? fieldPath,
    Value<String?>? pluginName,
    Value<String?>? configType,
    Value<String?>? description,
    Value<String?>? tooltip,
    Value<String?>? valueType,
    Value<String?>? widgetHint,
    Value<String?>? allowedValues,
    Value<String?>? defaultValue,
    Value<String?>? autocompleteSource,
    Value<String?>? imagePreviewUrl,
    Value<String?>? conditionalField,
    Value<String?>? presetName,
    Value<double>? confidence,
    Value<String>? version,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FieldMetadataTableCompanion(
      id: id ?? this.id,
      fieldPath: fieldPath ?? this.fieldPath,
      pluginName: pluginName ?? this.pluginName,
      configType: configType ?? this.configType,
      description: description ?? this.description,
      tooltip: tooltip ?? this.tooltip,
      valueType: valueType ?? this.valueType,
      widgetHint: widgetHint ?? this.widgetHint,
      allowedValues: allowedValues ?? this.allowedValues,
      defaultValue: defaultValue ?? this.defaultValue,
      autocompleteSource: autocompleteSource ?? this.autocompleteSource,
      imagePreviewUrl: imagePreviewUrl ?? this.imagePreviewUrl,
      conditionalField: conditionalField ?? this.conditionalField,
      presetName: presetName ?? this.presetName,
      confidence: confidence ?? this.confidence,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fieldPath.present) {
      map['field_path'] = Variable<String>(fieldPath.value);
    }
    if (pluginName.present) {
      map['plugin_name'] = Variable<String>(pluginName.value);
    }
    if (configType.present) {
      map['config_type'] = Variable<String>(configType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (tooltip.present) {
      map['tooltip'] = Variable<String>(tooltip.value);
    }
    if (valueType.present) {
      map['value_type'] = Variable<String>(valueType.value);
    }
    if (widgetHint.present) {
      map['widget_hint'] = Variable<String>(widgetHint.value);
    }
    if (allowedValues.present) {
      map['allowed_values'] = Variable<String>(allowedValues.value);
    }
    if (defaultValue.present) {
      map['default_value'] = Variable<String>(defaultValue.value);
    }
    if (autocompleteSource.present) {
      map['autocomplete_source'] = Variable<String>(autocompleteSource.value);
    }
    if (imagePreviewUrl.present) {
      map['image_preview_url'] = Variable<String>(imagePreviewUrl.value);
    }
    if (conditionalField.present) {
      map['conditional_field'] = Variable<String>(conditionalField.value);
    }
    if (presetName.present) {
      map['preset_name'] = Variable<String>(presetName.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldMetadataTableCompanion(')
          ..write('id: $id, ')
          ..write('fieldPath: $fieldPath, ')
          ..write('pluginName: $pluginName, ')
          ..write('configType: $configType, ')
          ..write('description: $description, ')
          ..write('tooltip: $tooltip, ')
          ..write('valueType: $valueType, ')
          ..write('widgetHint: $widgetHint, ')
          ..write('allowedValues: $allowedValues, ')
          ..write('defaultValue: $defaultValue, ')
          ..write('autocompleteSource: $autocompleteSource, ')
          ..write('imagePreviewUrl: $imagePreviewUrl, ')
          ..write('conditionalField: $conditionalField, ')
          ..write('presetName: $presetName, ')
          ..write('confidence: $confidence, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MetadataConstraintsTableTable extends MetadataConstraintsTable
    with TableInfo<$MetadataConstraintsTableTable, MetadataConstraintRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetadataConstraintsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fieldMetadataIdMeta = const VerificationMeta(
    'fieldMetadataId',
  );
  @override
  late final GeneratedColumn<int> fieldMetadataId = GeneratedColumn<int>(
    'field_metadata_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES field_metadata (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _constraintTypeMeta = const VerificationMeta(
    'constraintType',
  );
  @override
  late final GeneratedColumn<String> constraintType = GeneratedColumn<String>(
    'constraint_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldMetadataId,
    constraintType,
    value,
    errorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metadata_constraints';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetadataConstraintRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_metadata_id')) {
      context.handle(
        _fieldMetadataIdMeta,
        fieldMetadataId.isAcceptableOrUnknown(
          data['field_metadata_id']!,
          _fieldMetadataIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fieldMetadataIdMeta);
    }
    if (data.containsKey('constraint_type')) {
      context.handle(
        _constraintTypeMeta,
        constraintType.isAcceptableOrUnknown(
          data['constraint_type']!,
          _constraintTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_constraintTypeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetadataConstraintRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetadataConstraintRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fieldMetadataId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}field_metadata_id'],
      )!,
      constraintType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}constraint_type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
    );
  }

  @override
  $MetadataConstraintsTableTable createAlias(String alias) {
    return $MetadataConstraintsTableTable(attachedDatabase, alias);
  }
}

class MetadataConstraintRow extends DataClass
    implements Insertable<MetadataConstraintRow> {
  /// Unique identifier.
  final int id;

  /// Foreign key to field_metadata table.
  final int fieldMetadataId;

  /// Type of constraint (e.g., "min", "max", "pattern", "required").
  final String constraintType;

  /// Value for the constraint as JSON.
  final String value;

  /// Error message to show when constraint is violated.
  final String? errorMessage;
  const MetadataConstraintRow({
    required this.id,
    required this.fieldMetadataId,
    required this.constraintType,
    required this.value,
    this.errorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['field_metadata_id'] = Variable<int>(fieldMetadataId);
    map['constraint_type'] = Variable<String>(constraintType);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  MetadataConstraintsTableCompanion toCompanion(bool nullToAbsent) {
    return MetadataConstraintsTableCompanion(
      id: Value(id),
      fieldMetadataId: Value(fieldMetadataId),
      constraintType: Value(constraintType),
      value: Value(value),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory MetadataConstraintRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetadataConstraintRow(
      id: serializer.fromJson<int>(json['id']),
      fieldMetadataId: serializer.fromJson<int>(json['fieldMetadataId']),
      constraintType: serializer.fromJson<String>(json['constraintType']),
      value: serializer.fromJson<String>(json['value']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fieldMetadataId': serializer.toJson<int>(fieldMetadataId),
      'constraintType': serializer.toJson<String>(constraintType),
      'value': serializer.toJson<String>(value),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  MetadataConstraintRow copyWith({
    int? id,
    int? fieldMetadataId,
    String? constraintType,
    String? value,
    Value<String?> errorMessage = const Value.absent(),
  }) => MetadataConstraintRow(
    id: id ?? this.id,
    fieldMetadataId: fieldMetadataId ?? this.fieldMetadataId,
    constraintType: constraintType ?? this.constraintType,
    value: value ?? this.value,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
  );
  MetadataConstraintRow copyWithCompanion(
    MetadataConstraintsTableCompanion data,
  ) {
    return MetadataConstraintRow(
      id: data.id.present ? data.id.value : this.id,
      fieldMetadataId: data.fieldMetadataId.present
          ? data.fieldMetadataId.value
          : this.fieldMetadataId,
      constraintType: data.constraintType.present
          ? data.constraintType.value
          : this.constraintType,
      value: data.value.present ? data.value.value : this.value,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetadataConstraintRow(')
          ..write('id: $id, ')
          ..write('fieldMetadataId: $fieldMetadataId, ')
          ..write('constraintType: $constraintType, ')
          ..write('value: $value, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fieldMetadataId, constraintType, value, errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetadataConstraintRow &&
          other.id == this.id &&
          other.fieldMetadataId == this.fieldMetadataId &&
          other.constraintType == this.constraintType &&
          other.value == this.value &&
          other.errorMessage == this.errorMessage);
}

class MetadataConstraintsTableCompanion
    extends UpdateCompanion<MetadataConstraintRow> {
  final Value<int> id;
  final Value<int> fieldMetadataId;
  final Value<String> constraintType;
  final Value<String> value;
  final Value<String?> errorMessage;
  const MetadataConstraintsTableCompanion({
    this.id = const Value.absent(),
    this.fieldMetadataId = const Value.absent(),
    this.constraintType = const Value.absent(),
    this.value = const Value.absent(),
    this.errorMessage = const Value.absent(),
  });
  MetadataConstraintsTableCompanion.insert({
    this.id = const Value.absent(),
    required int fieldMetadataId,
    required String constraintType,
    required String value,
    this.errorMessage = const Value.absent(),
  }) : fieldMetadataId = Value(fieldMetadataId),
       constraintType = Value(constraintType),
       value = Value(value);
  static Insertable<MetadataConstraintRow> custom({
    Expression<int>? id,
    Expression<int>? fieldMetadataId,
    Expression<String>? constraintType,
    Expression<String>? value,
    Expression<String>? errorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldMetadataId != null) 'field_metadata_id': fieldMetadataId,
      if (constraintType != null) 'constraint_type': constraintType,
      if (value != null) 'value': value,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }

  MetadataConstraintsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? fieldMetadataId,
    Value<String>? constraintType,
    Value<String>? value,
    Value<String?>? errorMessage,
  }) {
    return MetadataConstraintsTableCompanion(
      id: id ?? this.id,
      fieldMetadataId: fieldMetadataId ?? this.fieldMetadataId,
      constraintType: constraintType ?? this.constraintType,
      value: value ?? this.value,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fieldMetadataId.present) {
      map['field_metadata_id'] = Variable<int>(fieldMetadataId.value);
    }
    if (constraintType.present) {
      map['constraint_type'] = Variable<String>(constraintType.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetadataConstraintsTableCompanion(')
          ..write('id: $id, ')
          ..write('fieldMetadataId: $fieldMetadataId, ')
          ..write('constraintType: $constraintType, ')
          ..write('value: $value, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }
}

class $ConfigPatternsTableTable extends ConfigPatternsTable
    with TableInfo<$ConfigPatternsTableTable, ConfigPatternRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfigPatternsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pluginNameMeta = const VerificationMeta(
    'pluginName',
  );
  @override
  late final GeneratedColumn<String> pluginName = GeneratedColumn<String>(
    'plugin_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _configTypeMeta = const VerificationMeta(
    'configType',
  );
  @override
  late final GeneratedColumn<String> configType = GeneratedColumn<String>(
    'config_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurrencesMeta = const VerificationMeta(
    'occurrences',
  );
  @override
  late final GeneratedColumn<int> occurrences = GeneratedColumn<int>(
    'occurrences',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(1),
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
    'last_seen',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _metadataIdMeta = const VerificationMeta(
    'metadataId',
  );
  @override
  late final GeneratedColumn<int> metadataId = GeneratedColumn<int>(
    'metadata_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldName,
    pluginName,
    configType,
    confidence,
    occurrences,
    lastSeen,
    createdAt,
    metadataId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'config_patterns';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConfigPatternRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('plugin_name')) {
      context.handle(
        _pluginNameMeta,
        pluginName.isAcceptableOrUnknown(data['plugin_name']!, _pluginNameMeta),
      );
    }
    if (data.containsKey('config_type')) {
      context.handle(
        _configTypeMeta,
        configType.isAcceptableOrUnknown(data['config_type']!, _configTypeMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('occurrences')) {
      context.handle(
        _occurrencesMeta,
        occurrences.isAcceptableOrUnknown(
          data['occurrences']!,
          _occurrencesMeta,
        ),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    } else if (isInserting) {
      context.missing(_lastSeenMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('metadata_id')) {
      context.handle(
        _metadataIdMeta,
        metadataId.isAcceptableOrUnknown(data['metadata_id']!, _metadataIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfigPatternRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfigPatternRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fieldName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_name'],
      )!,
      pluginName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_name'],
      ),
      configType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config_type'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      occurrences: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurrences'],
      )!,
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      metadataId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}metadata_id'],
      ),
    );
  }

  @override
  $ConfigPatternsTableTable createAlias(String alias) {
    return $ConfigPatternsTableTable(attachedDatabase, alias);
  }
}

class ConfigPatternRow extends DataClass
    implements Insertable<ConfigPatternRow> {
  /// Unique identifier (UUID stored as text).
  final String id;

  /// Name of the field this pattern applies to.
  final String fieldName;

  /// Plugin name (if pattern is plugin-specific).
  final String? pluginName;

  /// Type of config (e.g., "skill", "loot_table", "npc").
  final String? configType;

  /// Confidence score (0.0 to 1.0).
  final double confidence;

  /// Number of times this pattern was observed.
  final int occurrences;

  /// Last time this pattern was observed.
  final DateTime lastSeen;

  /// When this pattern was first created.
  final DateTime createdAt;

  /// Foreign key to field_metadata (the inferred metadata).
  final int? metadataId;
  const ConfigPatternRow({
    required this.id,
    required this.fieldName,
    this.pluginName,
    this.configType,
    required this.confidence,
    required this.occurrences,
    required this.lastSeen,
    required this.createdAt,
    this.metadataId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_name'] = Variable<String>(fieldName);
    if (!nullToAbsent || pluginName != null) {
      map['plugin_name'] = Variable<String>(pluginName);
    }
    if (!nullToAbsent || configType != null) {
      map['config_type'] = Variable<String>(configType);
    }
    map['confidence'] = Variable<double>(confidence);
    map['occurrences'] = Variable<int>(occurrences);
    map['last_seen'] = Variable<DateTime>(lastSeen);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || metadataId != null) {
      map['metadata_id'] = Variable<int>(metadataId);
    }
    return map;
  }

  ConfigPatternsTableCompanion toCompanion(bool nullToAbsent) {
    return ConfigPatternsTableCompanion(
      id: Value(id),
      fieldName: Value(fieldName),
      pluginName: pluginName == null && nullToAbsent
          ? const Value.absent()
          : Value(pluginName),
      configType: configType == null && nullToAbsent
          ? const Value.absent()
          : Value(configType),
      confidence: Value(confidence),
      occurrences: Value(occurrences),
      lastSeen: Value(lastSeen),
      createdAt: Value(createdAt),
      metadataId: metadataId == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataId),
    );
  }

  factory ConfigPatternRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfigPatternRow(
      id: serializer.fromJson<String>(json['id']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      pluginName: serializer.fromJson<String?>(json['pluginName']),
      configType: serializer.fromJson<String?>(json['configType']),
      confidence: serializer.fromJson<double>(json['confidence']),
      occurrences: serializer.fromJson<int>(json['occurrences']),
      lastSeen: serializer.fromJson<DateTime>(json['lastSeen']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      metadataId: serializer.fromJson<int?>(json['metadataId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldName': serializer.toJson<String>(fieldName),
      'pluginName': serializer.toJson<String?>(pluginName),
      'configType': serializer.toJson<String?>(configType),
      'confidence': serializer.toJson<double>(confidence),
      'occurrences': serializer.toJson<int>(occurrences),
      'lastSeen': serializer.toJson<DateTime>(lastSeen),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'metadataId': serializer.toJson<int?>(metadataId),
    };
  }

  ConfigPatternRow copyWith({
    String? id,
    String? fieldName,
    Value<String?> pluginName = const Value.absent(),
    Value<String?> configType = const Value.absent(),
    double? confidence,
    int? occurrences,
    DateTime? lastSeen,
    DateTime? createdAt,
    Value<int?> metadataId = const Value.absent(),
  }) => ConfigPatternRow(
    id: id ?? this.id,
    fieldName: fieldName ?? this.fieldName,
    pluginName: pluginName.present ? pluginName.value : this.pluginName,
    configType: configType.present ? configType.value : this.configType,
    confidence: confidence ?? this.confidence,
    occurrences: occurrences ?? this.occurrences,
    lastSeen: lastSeen ?? this.lastSeen,
    createdAt: createdAt ?? this.createdAt,
    metadataId: metadataId.present ? metadataId.value : this.metadataId,
  );
  ConfigPatternRow copyWithCompanion(ConfigPatternsTableCompanion data) {
    return ConfigPatternRow(
      id: data.id.present ? data.id.value : this.id,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      pluginName: data.pluginName.present
          ? data.pluginName.value
          : this.pluginName,
      configType: data.configType.present
          ? data.configType.value
          : this.configType,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      occurrences: data.occurrences.present
          ? data.occurrences.value
          : this.occurrences,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      metadataId: data.metadataId.present
          ? data.metadataId.value
          : this.metadataId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfigPatternRow(')
          ..write('id: $id, ')
          ..write('fieldName: $fieldName, ')
          ..write('pluginName: $pluginName, ')
          ..write('configType: $configType, ')
          ..write('confidence: $confidence, ')
          ..write('occurrences: $occurrences, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('createdAt: $createdAt, ')
          ..write('metadataId: $metadataId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fieldName,
    pluginName,
    configType,
    confidence,
    occurrences,
    lastSeen,
    createdAt,
    metadataId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigPatternRow &&
          other.id == this.id &&
          other.fieldName == this.fieldName &&
          other.pluginName == this.pluginName &&
          other.configType == this.configType &&
          other.confidence == this.confidence &&
          other.occurrences == this.occurrences &&
          other.lastSeen == this.lastSeen &&
          other.createdAt == this.createdAt &&
          other.metadataId == this.metadataId);
}

class ConfigPatternsTableCompanion extends UpdateCompanion<ConfigPatternRow> {
  final Value<String> id;
  final Value<String> fieldName;
  final Value<String?> pluginName;
  final Value<String?> configType;
  final Value<double> confidence;
  final Value<int> occurrences;
  final Value<DateTime> lastSeen;
  final Value<DateTime> createdAt;
  final Value<int?> metadataId;
  final Value<int> rowid;
  const ConfigPatternsTableCompanion({
    this.id = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.pluginName = const Value.absent(),
    this.configType = const Value.absent(),
    this.confidence = const Value.absent(),
    this.occurrences = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.metadataId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfigPatternsTableCompanion.insert({
    required String id,
    required String fieldName,
    this.pluginName = const Value.absent(),
    this.configType = const Value.absent(),
    required double confidence,
    this.occurrences = const Value.absent(),
    required DateTime lastSeen,
    this.createdAt = const Value.absent(),
    this.metadataId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fieldName = Value(fieldName),
       confidence = Value(confidence),
       lastSeen = Value(lastSeen);
  static Insertable<ConfigPatternRow> custom({
    Expression<String>? id,
    Expression<String>? fieldName,
    Expression<String>? pluginName,
    Expression<String>? configType,
    Expression<double>? confidence,
    Expression<int>? occurrences,
    Expression<DateTime>? lastSeen,
    Expression<DateTime>? createdAt,
    Expression<int>? metadataId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldName != null) 'field_name': fieldName,
      if (pluginName != null) 'plugin_name': pluginName,
      if (configType != null) 'config_type': configType,
      if (confidence != null) 'confidence': confidence,
      if (occurrences != null) 'occurrences': occurrences,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (createdAt != null) 'created_at': createdAt,
      if (metadataId != null) 'metadata_id': metadataId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfigPatternsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? fieldName,
    Value<String?>? pluginName,
    Value<String?>? configType,
    Value<double>? confidence,
    Value<int>? occurrences,
    Value<DateTime>? lastSeen,
    Value<DateTime>? createdAt,
    Value<int?>? metadataId,
    Value<int>? rowid,
  }) {
    return ConfigPatternsTableCompanion(
      id: id ?? this.id,
      fieldName: fieldName ?? this.fieldName,
      pluginName: pluginName ?? this.pluginName,
      configType: configType ?? this.configType,
      confidence: confidence ?? this.confidence,
      occurrences: occurrences ?? this.occurrences,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      metadataId: metadataId ?? this.metadataId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (pluginName.present) {
      map['plugin_name'] = Variable<String>(pluginName.value);
    }
    if (configType.present) {
      map['config_type'] = Variable<String>(configType.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (occurrences.present) {
      map['occurrences'] = Variable<int>(occurrences.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (metadataId.present) {
      map['metadata_id'] = Variable<int>(metadataId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfigPatternsTableCompanion(')
          ..write('id: $id, ')
          ..write('fieldName: $fieldName, ')
          ..write('pluginName: $pluginName, ')
          ..write('configType: $configType, ')
          ..write('confidence: $confidence, ')
          ..write('occurrences: $occurrences, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('createdAt: $createdAt, ')
          ..write('metadataId: $metadataId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PatternFeedbackTableTable extends PatternFeedbackTable
    with TableInfo<$PatternFeedbackTableTable, PatternFeedbackRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatternFeedbackTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _patternIdMeta = const VerificationMeta(
    'patternId',
  );
  @override
  late final GeneratedColumn<String> patternId = GeneratedColumn<String>(
    'pattern_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES config_patterns (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _acceptedMeta = const VerificationMeta(
    'accepted',
  );
  @override
  late final GeneratedColumn<bool> accepted = GeneratedColumn<bool>(
    'accepted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("accepted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _userModificationMeta = const VerificationMeta(
    'userModification',
  );
  @override
  late final GeneratedColumn<String> userModification = GeneratedColumn<String>(
    'user_modification',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feedbackAtMeta = const VerificationMeta(
    'feedbackAt',
  );
  @override
  late final GeneratedColumn<DateTime> feedbackAt = GeneratedColumn<DateTime>(
    'feedback_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patternId,
    accepted,
    userModification,
    feedbackAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pattern_feedback';
  @override
  VerificationContext validateIntegrity(
    Insertable<PatternFeedbackRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pattern_id')) {
      context.handle(
        _patternIdMeta,
        patternId.isAcceptableOrUnknown(data['pattern_id']!, _patternIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patternIdMeta);
    }
    if (data.containsKey('accepted')) {
      context.handle(
        _acceptedMeta,
        accepted.isAcceptableOrUnknown(data['accepted']!, _acceptedMeta),
      );
    } else if (isInserting) {
      context.missing(_acceptedMeta);
    }
    if (data.containsKey('user_modification')) {
      context.handle(
        _userModificationMeta,
        userModification.isAcceptableOrUnknown(
          data['user_modification']!,
          _userModificationMeta,
        ),
      );
    }
    if (data.containsKey('feedback_at')) {
      context.handle(
        _feedbackAtMeta,
        feedbackAt.isAcceptableOrUnknown(data['feedback_at']!, _feedbackAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatternFeedbackRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatternFeedbackRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      patternId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern_id'],
      )!,
      accepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}accepted'],
      )!,
      userModification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_modification'],
      ),
      feedbackAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}feedback_at'],
      )!,
    );
  }

  @override
  $PatternFeedbackTableTable createAlias(String alias) {
    return $PatternFeedbackTableTable(attachedDatabase, alias);
  }
}

class PatternFeedbackRow extends DataClass
    implements Insertable<PatternFeedbackRow> {
  /// Unique identifier.
  final int id;

  /// Foreign key to config_patterns.
  final String patternId;

  /// Whether the user accepted (true) or rejected (false) the pattern.
  final bool accepted;

  /// Optional user modification to the pattern as JSON.
  final String? userModification;

  /// When the feedback was provided.
  final DateTime feedbackAt;
  const PatternFeedbackRow({
    required this.id,
    required this.patternId,
    required this.accepted,
    this.userModification,
    required this.feedbackAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pattern_id'] = Variable<String>(patternId);
    map['accepted'] = Variable<bool>(accepted);
    if (!nullToAbsent || userModification != null) {
      map['user_modification'] = Variable<String>(userModification);
    }
    map['feedback_at'] = Variable<DateTime>(feedbackAt);
    return map;
  }

  PatternFeedbackTableCompanion toCompanion(bool nullToAbsent) {
    return PatternFeedbackTableCompanion(
      id: Value(id),
      patternId: Value(patternId),
      accepted: Value(accepted),
      userModification: userModification == null && nullToAbsent
          ? const Value.absent()
          : Value(userModification),
      feedbackAt: Value(feedbackAt),
    );
  }

  factory PatternFeedbackRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatternFeedbackRow(
      id: serializer.fromJson<int>(json['id']),
      patternId: serializer.fromJson<String>(json['patternId']),
      accepted: serializer.fromJson<bool>(json['accepted']),
      userModification: serializer.fromJson<String?>(json['userModification']),
      feedbackAt: serializer.fromJson<DateTime>(json['feedbackAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patternId': serializer.toJson<String>(patternId),
      'accepted': serializer.toJson<bool>(accepted),
      'userModification': serializer.toJson<String?>(userModification),
      'feedbackAt': serializer.toJson<DateTime>(feedbackAt),
    };
  }

  PatternFeedbackRow copyWith({
    int? id,
    String? patternId,
    bool? accepted,
    Value<String?> userModification = const Value.absent(),
    DateTime? feedbackAt,
  }) => PatternFeedbackRow(
    id: id ?? this.id,
    patternId: patternId ?? this.patternId,
    accepted: accepted ?? this.accepted,
    userModification: userModification.present
        ? userModification.value
        : this.userModification,
    feedbackAt: feedbackAt ?? this.feedbackAt,
  );
  PatternFeedbackRow copyWithCompanion(PatternFeedbackTableCompanion data) {
    return PatternFeedbackRow(
      id: data.id.present ? data.id.value : this.id,
      patternId: data.patternId.present ? data.patternId.value : this.patternId,
      accepted: data.accepted.present ? data.accepted.value : this.accepted,
      userModification: data.userModification.present
          ? data.userModification.value
          : this.userModification,
      feedbackAt: data.feedbackAt.present
          ? data.feedbackAt.value
          : this.feedbackAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatternFeedbackRow(')
          ..write('id: $id, ')
          ..write('patternId: $patternId, ')
          ..write('accepted: $accepted, ')
          ..write('userModification: $userModification, ')
          ..write('feedbackAt: $feedbackAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patternId, accepted, userModification, feedbackAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatternFeedbackRow &&
          other.id == this.id &&
          other.patternId == this.patternId &&
          other.accepted == this.accepted &&
          other.userModification == this.userModification &&
          other.feedbackAt == this.feedbackAt);
}

class PatternFeedbackTableCompanion
    extends UpdateCompanion<PatternFeedbackRow> {
  final Value<int> id;
  final Value<String> patternId;
  final Value<bool> accepted;
  final Value<String?> userModification;
  final Value<DateTime> feedbackAt;
  const PatternFeedbackTableCompanion({
    this.id = const Value.absent(),
    this.patternId = const Value.absent(),
    this.accepted = const Value.absent(),
    this.userModification = const Value.absent(),
    this.feedbackAt = const Value.absent(),
  });
  PatternFeedbackTableCompanion.insert({
    this.id = const Value.absent(),
    required String patternId,
    required bool accepted,
    this.userModification = const Value.absent(),
    this.feedbackAt = const Value.absent(),
  }) : patternId = Value(patternId),
       accepted = Value(accepted);
  static Insertable<PatternFeedbackRow> custom({
    Expression<int>? id,
    Expression<String>? patternId,
    Expression<bool>? accepted,
    Expression<String>? userModification,
    Expression<DateTime>? feedbackAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patternId != null) 'pattern_id': patternId,
      if (accepted != null) 'accepted': accepted,
      if (userModification != null) 'user_modification': userModification,
      if (feedbackAt != null) 'feedback_at': feedbackAt,
    });
  }

  PatternFeedbackTableCompanion copyWith({
    Value<int>? id,
    Value<String>? patternId,
    Value<bool>? accepted,
    Value<String?>? userModification,
    Value<DateTime>? feedbackAt,
  }) {
    return PatternFeedbackTableCompanion(
      id: id ?? this.id,
      patternId: patternId ?? this.patternId,
      accepted: accepted ?? this.accepted,
      userModification: userModification ?? this.userModification,
      feedbackAt: feedbackAt ?? this.feedbackAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patternId.present) {
      map['pattern_id'] = Variable<String>(patternId.value);
    }
    if (accepted.present) {
      map['accepted'] = Variable<bool>(accepted.value);
    }
    if (userModification.present) {
      map['user_modification'] = Variable<String>(userModification.value);
    }
    if (feedbackAt.present) {
      map['feedback_at'] = Variable<DateTime>(feedbackAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatternFeedbackTableCompanion(')
          ..write('id: $id, ')
          ..write('patternId: $patternId, ')
          ..write('accepted: $accepted, ')
          ..write('userModification: $userModification, ')
          ..write('feedbackAt: $feedbackAt')
          ..write(')'))
        .toString();
  }
}

class $FieldStatisticsTableTable extends FieldStatisticsTable
    with TableInfo<$FieldStatisticsTableTable, FieldStatisticsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldStatisticsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pluginNameMeta = const VerificationMeta(
    'pluginName',
  );
  @override
  late final GeneratedColumn<String> pluginName = GeneratedColumn<String>(
    'plugin_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _configTypeMeta = const VerificationMeta(
    'configType',
  );
  @override
  late final GeneratedColumn<String> configType = GeneratedColumn<String>(
    'config_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commonValueTypeMeta = const VerificationMeta(
    'commonValueType',
  );
  @override
  late final GeneratedColumn<String> commonValueType = GeneratedColumn<String>(
    'common_value_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minValueMeta = const VerificationMeta(
    'minValue',
  );
  @override
  late final GeneratedColumn<String> minValue = GeneratedColumn<String>(
    'min_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxValueMeta = const VerificationMeta(
    'maxValue',
  );
  @override
  late final GeneratedColumn<String> maxValue = GeneratedColumn<String>(
    'max_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enumValuesMeta = const VerificationMeta(
    'enumValues',
  );
  @override
  late final GeneratedColumn<String> enumValues = GeneratedColumn<String>(
    'enum_values',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<int> frequency = GeneratedColumn<int>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(1),
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
    'last_seen',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldName,
    pluginName,
    configType,
    commonValueType,
    minValue,
    maxValue,
    enumValues,
    frequency,
    lastSeen,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'field_statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<FieldStatisticsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('plugin_name')) {
      context.handle(
        _pluginNameMeta,
        pluginName.isAcceptableOrUnknown(data['plugin_name']!, _pluginNameMeta),
      );
    }
    if (data.containsKey('config_type')) {
      context.handle(
        _configTypeMeta,
        configType.isAcceptableOrUnknown(data['config_type']!, _configTypeMeta),
      );
    }
    if (data.containsKey('common_value_type')) {
      context.handle(
        _commonValueTypeMeta,
        commonValueType.isAcceptableOrUnknown(
          data['common_value_type']!,
          _commonValueTypeMeta,
        ),
      );
    }
    if (data.containsKey('min_value')) {
      context.handle(
        _minValueMeta,
        minValue.isAcceptableOrUnknown(data['min_value']!, _minValueMeta),
      );
    }
    if (data.containsKey('max_value')) {
      context.handle(
        _maxValueMeta,
        maxValue.isAcceptableOrUnknown(data['max_value']!, _maxValueMeta),
      );
    }
    if (data.containsKey('enum_values')) {
      context.handle(
        _enumValuesMeta,
        enumValues.isAcceptableOrUnknown(data['enum_values']!, _enumValuesMeta),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    } else if (isInserting) {
      context.missing(_lastSeenMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldStatisticsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldStatisticsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fieldName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_name'],
      )!,
      pluginName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_name'],
      ),
      configType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config_type'],
      ),
      commonValueType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_value_type'],
      ),
      minValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}min_value'],
      ),
      maxValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}max_value'],
      ),
      enumValues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enum_values'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency'],
      )!,
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FieldStatisticsTableTable createAlias(String alias) {
    return $FieldStatisticsTableTable(attachedDatabase, alias);
  }
}

class FieldStatisticsRow extends DataClass
    implements Insertable<FieldStatisticsRow> {
  /// Unique identifier.
  final int id;

  /// Field name (without path).
  final String fieldName;

  /// Optional plugin name.
  final String? pluginName;

  /// Optional config type.
  final String? configType;

  /// Most common value type observed.
  final String? commonValueType;

  /// Observed minimum value (for numeric fields) as JSON.
  final String? minValue;

  /// Observed maximum value (for numeric fields) as JSON.
  final String? maxValue;

  /// Observed enum values as JSON array.
  final String? enumValues;

  /// Number of times this field was encountered.
  final int frequency;

  /// Last time this field was seen.
  final DateTime lastSeen;

  /// When this statistic was first created.
  final DateTime createdAt;
  const FieldStatisticsRow({
    required this.id,
    required this.fieldName,
    this.pluginName,
    this.configType,
    this.commonValueType,
    this.minValue,
    this.maxValue,
    this.enumValues,
    required this.frequency,
    required this.lastSeen,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['field_name'] = Variable<String>(fieldName);
    if (!nullToAbsent || pluginName != null) {
      map['plugin_name'] = Variable<String>(pluginName);
    }
    if (!nullToAbsent || configType != null) {
      map['config_type'] = Variable<String>(configType);
    }
    if (!nullToAbsent || commonValueType != null) {
      map['common_value_type'] = Variable<String>(commonValueType);
    }
    if (!nullToAbsent || minValue != null) {
      map['min_value'] = Variable<String>(minValue);
    }
    if (!nullToAbsent || maxValue != null) {
      map['max_value'] = Variable<String>(maxValue);
    }
    if (!nullToAbsent || enumValues != null) {
      map['enum_values'] = Variable<String>(enumValues);
    }
    map['frequency'] = Variable<int>(frequency);
    map['last_seen'] = Variable<DateTime>(lastSeen);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FieldStatisticsTableCompanion toCompanion(bool nullToAbsent) {
    return FieldStatisticsTableCompanion(
      id: Value(id),
      fieldName: Value(fieldName),
      pluginName: pluginName == null && nullToAbsent
          ? const Value.absent()
          : Value(pluginName),
      configType: configType == null && nullToAbsent
          ? const Value.absent()
          : Value(configType),
      commonValueType: commonValueType == null && nullToAbsent
          ? const Value.absent()
          : Value(commonValueType),
      minValue: minValue == null && nullToAbsent
          ? const Value.absent()
          : Value(minValue),
      maxValue: maxValue == null && nullToAbsent
          ? const Value.absent()
          : Value(maxValue),
      enumValues: enumValues == null && nullToAbsent
          ? const Value.absent()
          : Value(enumValues),
      frequency: Value(frequency),
      lastSeen: Value(lastSeen),
      createdAt: Value(createdAt),
    );
  }

  factory FieldStatisticsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldStatisticsRow(
      id: serializer.fromJson<int>(json['id']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      pluginName: serializer.fromJson<String?>(json['pluginName']),
      configType: serializer.fromJson<String?>(json['configType']),
      commonValueType: serializer.fromJson<String?>(json['commonValueType']),
      minValue: serializer.fromJson<String?>(json['minValue']),
      maxValue: serializer.fromJson<String?>(json['maxValue']),
      enumValues: serializer.fromJson<String?>(json['enumValues']),
      frequency: serializer.fromJson<int>(json['frequency']),
      lastSeen: serializer.fromJson<DateTime>(json['lastSeen']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fieldName': serializer.toJson<String>(fieldName),
      'pluginName': serializer.toJson<String?>(pluginName),
      'configType': serializer.toJson<String?>(configType),
      'commonValueType': serializer.toJson<String?>(commonValueType),
      'minValue': serializer.toJson<String?>(minValue),
      'maxValue': serializer.toJson<String?>(maxValue),
      'enumValues': serializer.toJson<String?>(enumValues),
      'frequency': serializer.toJson<int>(frequency),
      'lastSeen': serializer.toJson<DateTime>(lastSeen),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FieldStatisticsRow copyWith({
    int? id,
    String? fieldName,
    Value<String?> pluginName = const Value.absent(),
    Value<String?> configType = const Value.absent(),
    Value<String?> commonValueType = const Value.absent(),
    Value<String?> minValue = const Value.absent(),
    Value<String?> maxValue = const Value.absent(),
    Value<String?> enumValues = const Value.absent(),
    int? frequency,
    DateTime? lastSeen,
    DateTime? createdAt,
  }) => FieldStatisticsRow(
    id: id ?? this.id,
    fieldName: fieldName ?? this.fieldName,
    pluginName: pluginName.present ? pluginName.value : this.pluginName,
    configType: configType.present ? configType.value : this.configType,
    commonValueType: commonValueType.present
        ? commonValueType.value
        : this.commonValueType,
    minValue: minValue.present ? minValue.value : this.minValue,
    maxValue: maxValue.present ? maxValue.value : this.maxValue,
    enumValues: enumValues.present ? enumValues.value : this.enumValues,
    frequency: frequency ?? this.frequency,
    lastSeen: lastSeen ?? this.lastSeen,
    createdAt: createdAt ?? this.createdAt,
  );
  FieldStatisticsRow copyWithCompanion(FieldStatisticsTableCompanion data) {
    return FieldStatisticsRow(
      id: data.id.present ? data.id.value : this.id,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      pluginName: data.pluginName.present
          ? data.pluginName.value
          : this.pluginName,
      configType: data.configType.present
          ? data.configType.value
          : this.configType,
      commonValueType: data.commonValueType.present
          ? data.commonValueType.value
          : this.commonValueType,
      minValue: data.minValue.present ? data.minValue.value : this.minValue,
      maxValue: data.maxValue.present ? data.maxValue.value : this.maxValue,
      enumValues: data.enumValues.present
          ? data.enumValues.value
          : this.enumValues,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FieldStatisticsRow(')
          ..write('id: $id, ')
          ..write('fieldName: $fieldName, ')
          ..write('pluginName: $pluginName, ')
          ..write('configType: $configType, ')
          ..write('commonValueType: $commonValueType, ')
          ..write('minValue: $minValue, ')
          ..write('maxValue: $maxValue, ')
          ..write('enumValues: $enumValues, ')
          ..write('frequency: $frequency, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fieldName,
    pluginName,
    configType,
    commonValueType,
    minValue,
    maxValue,
    enumValues,
    frequency,
    lastSeen,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FieldStatisticsRow &&
          other.id == this.id &&
          other.fieldName == this.fieldName &&
          other.pluginName == this.pluginName &&
          other.configType == this.configType &&
          other.commonValueType == this.commonValueType &&
          other.minValue == this.minValue &&
          other.maxValue == this.maxValue &&
          other.enumValues == this.enumValues &&
          other.frequency == this.frequency &&
          other.lastSeen == this.lastSeen &&
          other.createdAt == this.createdAt);
}

class FieldStatisticsTableCompanion
    extends UpdateCompanion<FieldStatisticsRow> {
  final Value<int> id;
  final Value<String> fieldName;
  final Value<String?> pluginName;
  final Value<String?> configType;
  final Value<String?> commonValueType;
  final Value<String?> minValue;
  final Value<String?> maxValue;
  final Value<String?> enumValues;
  final Value<int> frequency;
  final Value<DateTime> lastSeen;
  final Value<DateTime> createdAt;
  const FieldStatisticsTableCompanion({
    this.id = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.pluginName = const Value.absent(),
    this.configType = const Value.absent(),
    this.commonValueType = const Value.absent(),
    this.minValue = const Value.absent(),
    this.maxValue = const Value.absent(),
    this.enumValues = const Value.absent(),
    this.frequency = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FieldStatisticsTableCompanion.insert({
    this.id = const Value.absent(),
    required String fieldName,
    this.pluginName = const Value.absent(),
    this.configType = const Value.absent(),
    this.commonValueType = const Value.absent(),
    this.minValue = const Value.absent(),
    this.maxValue = const Value.absent(),
    this.enumValues = const Value.absent(),
    this.frequency = const Value.absent(),
    required DateTime lastSeen,
    this.createdAt = const Value.absent(),
  }) : fieldName = Value(fieldName),
       lastSeen = Value(lastSeen);
  static Insertable<FieldStatisticsRow> custom({
    Expression<int>? id,
    Expression<String>? fieldName,
    Expression<String>? pluginName,
    Expression<String>? configType,
    Expression<String>? commonValueType,
    Expression<String>? minValue,
    Expression<String>? maxValue,
    Expression<String>? enumValues,
    Expression<int>? frequency,
    Expression<DateTime>? lastSeen,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldName != null) 'field_name': fieldName,
      if (pluginName != null) 'plugin_name': pluginName,
      if (configType != null) 'config_type': configType,
      if (commonValueType != null) 'common_value_type': commonValueType,
      if (minValue != null) 'min_value': minValue,
      if (maxValue != null) 'max_value': maxValue,
      if (enumValues != null) 'enum_values': enumValues,
      if (frequency != null) 'frequency': frequency,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FieldStatisticsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? fieldName,
    Value<String?>? pluginName,
    Value<String?>? configType,
    Value<String?>? commonValueType,
    Value<String?>? minValue,
    Value<String?>? maxValue,
    Value<String?>? enumValues,
    Value<int>? frequency,
    Value<DateTime>? lastSeen,
    Value<DateTime>? createdAt,
  }) {
    return FieldStatisticsTableCompanion(
      id: id ?? this.id,
      fieldName: fieldName ?? this.fieldName,
      pluginName: pluginName ?? this.pluginName,
      configType: configType ?? this.configType,
      commonValueType: commonValueType ?? this.commonValueType,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      enumValues: enumValues ?? this.enumValues,
      frequency: frequency ?? this.frequency,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (pluginName.present) {
      map['plugin_name'] = Variable<String>(pluginName.value);
    }
    if (configType.present) {
      map['config_type'] = Variable<String>(configType.value);
    }
    if (commonValueType.present) {
      map['common_value_type'] = Variable<String>(commonValueType.value);
    }
    if (minValue.present) {
      map['min_value'] = Variable<String>(minValue.value);
    }
    if (maxValue.present) {
      map['max_value'] = Variable<String>(maxValue.value);
    }
    if (enumValues.present) {
      map['enum_values'] = Variable<String>(enumValues.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldStatisticsTableCompanion(')
          ..write('id: $id, ')
          ..write('fieldName: $fieldName, ')
          ..write('pluginName: $pluginName, ')
          ..write('configType: $configType, ')
          ..write('commonValueType: $commonValueType, ')
          ..write('minValue: $minValue, ')
          ..write('maxValue: $maxValue, ')
          ..write('enumValues: $enumValues, ')
          ..write('frequency: $frequency, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentationSourcesTableTable extends DocumentationSourcesTable
    with TableInfo<$DocumentationSourcesTableTable, DocumentationSourceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentationSourcesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pluginNameMeta = const VerificationMeta(
    'pluginName',
  );
  @override
  late final GeneratedColumn<String> pluginName = GeneratedColumn<String>(
    'plugin_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pluginName,
    sourceType,
    url,
    priority,
    enabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documentation_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentationSourceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plugin_name')) {
      context.handle(
        _pluginNameMeta,
        pluginName.isAcceptableOrUnknown(data['plugin_name']!, _pluginNameMeta),
      );
    } else if (isInserting) {
      context.missing(_pluginNameMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentationSourceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentationSourceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pluginName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_name'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DocumentationSourcesTableTable createAlias(String alias) {
    return $DocumentationSourcesTableTable(attachedDatabase, alias);
  }
}

class DocumentationSourceRow extends DataClass
    implements Insertable<DocumentationSourceRow> {
  /// Unique identifier.
  final int id;

  /// Plugin name this documentation is for.
  final String pluginName;

  /// Type of source (e.g., "github_readme", "wiki", "api_docs", "custom").
  final String sourceType;

  /// URL to the documentation.
  final String url;

  /// Priority/order for checking sources (lower = higher priority).
  final int priority;

  /// Whether this source is enabled.
  final bool enabled;

  /// When this source was added.
  final DateTime createdAt;

  /// When this source was last updated.
  final DateTime updatedAt;
  const DocumentationSourceRow({
    required this.id,
    required this.pluginName,
    required this.sourceType,
    required this.url,
    required this.priority,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plugin_name'] = Variable<String>(pluginName);
    map['source_type'] = Variable<String>(sourceType);
    map['url'] = Variable<String>(url);
    map['priority'] = Variable<int>(priority);
    map['enabled'] = Variable<bool>(enabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentationSourcesTableCompanion toCompanion(bool nullToAbsent) {
    return DocumentationSourcesTableCompanion(
      id: Value(id),
      pluginName: Value(pluginName),
      sourceType: Value(sourceType),
      url: Value(url),
      priority: Value(priority),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DocumentationSourceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentationSourceRow(
      id: serializer.fromJson<int>(json['id']),
      pluginName: serializer.fromJson<String>(json['pluginName']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      url: serializer.fromJson<String>(json['url']),
      priority: serializer.fromJson<int>(json['priority']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pluginName': serializer.toJson<String>(pluginName),
      'sourceType': serializer.toJson<String>(sourceType),
      'url': serializer.toJson<String>(url),
      'priority': serializer.toJson<int>(priority),
      'enabled': serializer.toJson<bool>(enabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DocumentationSourceRow copyWith({
    int? id,
    String? pluginName,
    String? sourceType,
    String? url,
    int? priority,
    bool? enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DocumentationSourceRow(
    id: id ?? this.id,
    pluginName: pluginName ?? this.pluginName,
    sourceType: sourceType ?? this.sourceType,
    url: url ?? this.url,
    priority: priority ?? this.priority,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DocumentationSourceRow copyWithCompanion(
    DocumentationSourcesTableCompanion data,
  ) {
    return DocumentationSourceRow(
      id: data.id.present ? data.id.value : this.id,
      pluginName: data.pluginName.present
          ? data.pluginName.value
          : this.pluginName,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      url: data.url.present ? data.url.value : this.url,
      priority: data.priority.present ? data.priority.value : this.priority,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentationSourceRow(')
          ..write('id: $id, ')
          ..write('pluginName: $pluginName, ')
          ..write('sourceType: $sourceType, ')
          ..write('url: $url, ')
          ..write('priority: $priority, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pluginName,
    sourceType,
    url,
    priority,
    enabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentationSourceRow &&
          other.id == this.id &&
          other.pluginName == this.pluginName &&
          other.sourceType == this.sourceType &&
          other.url == this.url &&
          other.priority == this.priority &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DocumentationSourcesTableCompanion
    extends UpdateCompanion<DocumentationSourceRow> {
  final Value<int> id;
  final Value<String> pluginName;
  final Value<String> sourceType;
  final Value<String> url;
  final Value<int> priority;
  final Value<bool> enabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DocumentationSourcesTableCompanion({
    this.id = const Value.absent(),
    this.pluginName = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.url = const Value.absent(),
    this.priority = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DocumentationSourcesTableCompanion.insert({
    this.id = const Value.absent(),
    required String pluginName,
    required String sourceType,
    required String url,
    this.priority = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : pluginName = Value(pluginName),
       sourceType = Value(sourceType),
       url = Value(url);
  static Insertable<DocumentationSourceRow> custom({
    Expression<int>? id,
    Expression<String>? pluginName,
    Expression<String>? sourceType,
    Expression<String>? url,
    Expression<int>? priority,
    Expression<bool>? enabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pluginName != null) 'plugin_name': pluginName,
      if (sourceType != null) 'source_type': sourceType,
      if (url != null) 'url': url,
      if (priority != null) 'priority': priority,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DocumentationSourcesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? pluginName,
    Value<String>? sourceType,
    Value<String>? url,
    Value<int>? priority,
    Value<bool>? enabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return DocumentationSourcesTableCompanion(
      id: id ?? this.id,
      pluginName: pluginName ?? this.pluginName,
      sourceType: sourceType ?? this.sourceType,
      url: url ?? this.url,
      priority: priority ?? this.priority,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pluginName.present) {
      map['plugin_name'] = Variable<String>(pluginName.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentationSourcesTableCompanion(')
          ..write('id: $id, ')
          ..write('pluginName: $pluginName, ')
          ..write('sourceType: $sourceType, ')
          ..write('url: $url, ')
          ..write('priority: $priority, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentationCacheTableTable extends DocumentationCacheTable
    with TableInfo<$DocumentationCacheTableTable, DocumentationCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentationCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documentation_sources (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('text'),
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceId,
    url,
    content,
    contentType,
    fetchedAt,
    expiresAt,
    etag,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documentation_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentationCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentationCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentationCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_id'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      ),
    );
  }

  @override
  $DocumentationCacheTableTable createAlias(String alias) {
    return $DocumentationCacheTableTable(attachedDatabase, alias);
  }
}

class DocumentationCacheRow extends DataClass
    implements Insertable<DocumentationCacheRow> {
  /// Unique identifier.
  final int id;

  /// Foreign key to documentation_sources.
  final int sourceId;

  /// URL that was fetched.
  final String url;

  /// Cached content (markdown, HTML, or plain text).
  final String content;

  /// Content type (e.g., "markdown", "html", "text").
  final String contentType;

  /// When the content was fetched.
  final DateTime fetchedAt;

  /// When the cache expires (for refresh logic).
  final DateTime expiresAt;

  /// ETag or version identifier for cache validation.
  final String? etag;
  const DocumentationCacheRow({
    required this.id,
    required this.sourceId,
    required this.url,
    required this.content,
    required this.contentType,
    required this.fetchedAt,
    required this.expiresAt,
    this.etag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_id'] = Variable<int>(sourceId);
    map['url'] = Variable<String>(url);
    map['content'] = Variable<String>(content);
    map['content_type'] = Variable<String>(contentType);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    if (!nullToAbsent || etag != null) {
      map['etag'] = Variable<String>(etag);
    }
    return map;
  }

  DocumentationCacheTableCompanion toCompanion(bool nullToAbsent) {
    return DocumentationCacheTableCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      url: Value(url),
      content: Value(content),
      contentType: Value(contentType),
      fetchedAt: Value(fetchedAt),
      expiresAt: Value(expiresAt),
      etag: etag == null && nullToAbsent ? const Value.absent() : Value(etag),
    );
  }

  factory DocumentationCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentationCacheRow(
      id: serializer.fromJson<int>(json['id']),
      sourceId: serializer.fromJson<int>(json['sourceId']),
      url: serializer.fromJson<String>(json['url']),
      content: serializer.fromJson<String>(json['content']),
      contentType: serializer.fromJson<String>(json['contentType']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      etag: serializer.fromJson<String?>(json['etag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceId': serializer.toJson<int>(sourceId),
      'url': serializer.toJson<String>(url),
      'content': serializer.toJson<String>(content),
      'contentType': serializer.toJson<String>(contentType),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'etag': serializer.toJson<String?>(etag),
    };
  }

  DocumentationCacheRow copyWith({
    int? id,
    int? sourceId,
    String? url,
    String? content,
    String? contentType,
    DateTime? fetchedAt,
    DateTime? expiresAt,
    Value<String?> etag = const Value.absent(),
  }) => DocumentationCacheRow(
    id: id ?? this.id,
    sourceId: sourceId ?? this.sourceId,
    url: url ?? this.url,
    content: content ?? this.content,
    contentType: contentType ?? this.contentType,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    etag: etag.present ? etag.value : this.etag,
  );
  DocumentationCacheRow copyWithCompanion(
    DocumentationCacheTableCompanion data,
  ) {
    return DocumentationCacheRow(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      url: data.url.present ? data.url.value : this.url,
      content: data.content.present ? data.content.value : this.content,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      etag: data.etag.present ? data.etag.value : this.etag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentationCacheRow(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('url: $url, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('etag: $etag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceId,
    url,
    content,
    contentType,
    fetchedAt,
    expiresAt,
    etag,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentationCacheRow &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.url == this.url &&
          other.content == this.content &&
          other.contentType == this.contentType &&
          other.fetchedAt == this.fetchedAt &&
          other.expiresAt == this.expiresAt &&
          other.etag == this.etag);
}

class DocumentationCacheTableCompanion
    extends UpdateCompanion<DocumentationCacheRow> {
  final Value<int> id;
  final Value<int> sourceId;
  final Value<String> url;
  final Value<String> content;
  final Value<String> contentType;
  final Value<DateTime> fetchedAt;
  final Value<DateTime> expiresAt;
  final Value<String?> etag;
  const DocumentationCacheTableCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.url = const Value.absent(),
    this.content = const Value.absent(),
    this.contentType = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.etag = const Value.absent(),
  });
  DocumentationCacheTableCompanion.insert({
    this.id = const Value.absent(),
    required int sourceId,
    required String url,
    required String content,
    this.contentType = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    required DateTime expiresAt,
    this.etag = const Value.absent(),
  }) : sourceId = Value(sourceId),
       url = Value(url),
       content = Value(content),
       expiresAt = Value(expiresAt);
  static Insertable<DocumentationCacheRow> custom({
    Expression<int>? id,
    Expression<int>? sourceId,
    Expression<String>? url,
    Expression<String>? content,
    Expression<String>? contentType,
    Expression<DateTime>? fetchedAt,
    Expression<DateTime>? expiresAt,
    Expression<String>? etag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (url != null) 'url': url,
      if (content != null) 'content': content,
      if (contentType != null) 'content_type': contentType,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (etag != null) 'etag': etag,
    });
  }

  DocumentationCacheTableCompanion copyWith({
    Value<int>? id,
    Value<int>? sourceId,
    Value<String>? url,
    Value<String>? content,
    Value<String>? contentType,
    Value<DateTime>? fetchedAt,
    Value<DateTime>? expiresAt,
    Value<String?>? etag,
  }) {
    return DocumentationCacheTableCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      url: url ?? this.url,
      content: content ?? this.content,
      contentType: contentType ?? this.contentType,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      etag: etag ?? this.etag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentationCacheTableCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('url: $url, ')
          ..write('content: $content, ')
          ..write('contentType: $contentType, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('etag: $etag')
          ..write(')'))
        .toString();
  }
}

class $ParsedFieldDocTableTable extends ParsedFieldDocTable
    with TableInfo<$ParsedFieldDocTableTable, ParsedFieldDocRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParsedFieldDocTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cacheIdMeta = const VerificationMeta(
    'cacheId',
  );
  @override
  late final GeneratedColumn<int> cacheId = GeneratedColumn<int>(
    'cache_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documentation_cache (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pluginNameMeta = const VerificationMeta(
    'pluginName',
  );
  @override
  late final GeneratedColumn<String> pluginName = GeneratedColumn<String>(
    'plugin_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validValuesMeta = const VerificationMeta(
    'validValues',
  );
  @override
  late final GeneratedColumn<String> validValues = GeneratedColumn<String>(
    'valid_values',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _examplesMeta = const VerificationMeta(
    'examples',
  );
  @override
  late final GeneratedColumn<String> examples = GeneratedColumn<String>(
    'examples',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeInfoMeta = const VerificationMeta(
    'typeInfo',
  );
  @override
  late final GeneratedColumn<String> typeInfo = GeneratedColumn<String>(
    'type_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant<double>(0.5),
  );
  static const VerificationMeta _parsedAtMeta = const VerificationMeta(
    'parsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> parsedAt = GeneratedColumn<DateTime>(
    'parsed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cacheId,
    pluginName,
    fieldName,
    description,
    validValues,
    examples,
    typeInfo,
    confidence,
    parsedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parsed_field_docs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParsedFieldDocRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cache_id')) {
      context.handle(
        _cacheIdMeta,
        cacheId.isAcceptableOrUnknown(data['cache_id']!, _cacheIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheIdMeta);
    }
    if (data.containsKey('plugin_name')) {
      context.handle(
        _pluginNameMeta,
        pluginName.isAcceptableOrUnknown(data['plugin_name']!, _pluginNameMeta),
      );
    } else if (isInserting) {
      context.missing(_pluginNameMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('valid_values')) {
      context.handle(
        _validValuesMeta,
        validValues.isAcceptableOrUnknown(
          data['valid_values']!,
          _validValuesMeta,
        ),
      );
    }
    if (data.containsKey('examples')) {
      context.handle(
        _examplesMeta,
        examples.isAcceptableOrUnknown(data['examples']!, _examplesMeta),
      );
    }
    if (data.containsKey('type_info')) {
      context.handle(
        _typeInfoMeta,
        typeInfo.isAcceptableOrUnknown(data['type_info']!, _typeInfoMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('parsed_at')) {
      context.handle(
        _parsedAtMeta,
        parsedAt.isAcceptableOrUnknown(data['parsed_at']!, _parsedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParsedFieldDocRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParsedFieldDocRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cacheId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cache_id'],
      )!,
      pluginName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plugin_name'],
      )!,
      fieldName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      validValues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valid_values'],
      ),
      examples: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}examples'],
      ),
      typeInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_info'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      parsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}parsed_at'],
      )!,
    );
  }

  @override
  $ParsedFieldDocTableTable createAlias(String alias) {
    return $ParsedFieldDocTableTable(attachedDatabase, alias);
  }
}

class ParsedFieldDocRow extends DataClass
    implements Insertable<ParsedFieldDocRow> {
  /// Unique identifier.
  final int id;

  /// Foreign key to documentation_cache.
  final int cacheId;

  /// Plugin name.
  final String pluginName;

  /// Field name or path.
  final String fieldName;

  /// Extracted description.
  final String? description;

  /// Extracted valid values as JSON array.
  final String? validValues;

  /// Extracted examples as JSON.
  final String? examples;

  /// Extracted type information.
  final String? typeInfo;

  /// Confidence of the extraction (0.0 to 1.0).
  final double confidence;

  /// When this was parsed.
  final DateTime parsedAt;
  const ParsedFieldDocRow({
    required this.id,
    required this.cacheId,
    required this.pluginName,
    required this.fieldName,
    this.description,
    this.validValues,
    this.examples,
    this.typeInfo,
    required this.confidence,
    required this.parsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cache_id'] = Variable<int>(cacheId);
    map['plugin_name'] = Variable<String>(pluginName);
    map['field_name'] = Variable<String>(fieldName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || validValues != null) {
      map['valid_values'] = Variable<String>(validValues);
    }
    if (!nullToAbsent || examples != null) {
      map['examples'] = Variable<String>(examples);
    }
    if (!nullToAbsent || typeInfo != null) {
      map['type_info'] = Variable<String>(typeInfo);
    }
    map['confidence'] = Variable<double>(confidence);
    map['parsed_at'] = Variable<DateTime>(parsedAt);
    return map;
  }

  ParsedFieldDocTableCompanion toCompanion(bool nullToAbsent) {
    return ParsedFieldDocTableCompanion(
      id: Value(id),
      cacheId: Value(cacheId),
      pluginName: Value(pluginName),
      fieldName: Value(fieldName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      validValues: validValues == null && nullToAbsent
          ? const Value.absent()
          : Value(validValues),
      examples: examples == null && nullToAbsent
          ? const Value.absent()
          : Value(examples),
      typeInfo: typeInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(typeInfo),
      confidence: Value(confidence),
      parsedAt: Value(parsedAt),
    );
  }

  factory ParsedFieldDocRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParsedFieldDocRow(
      id: serializer.fromJson<int>(json['id']),
      cacheId: serializer.fromJson<int>(json['cacheId']),
      pluginName: serializer.fromJson<String>(json['pluginName']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      description: serializer.fromJson<String?>(json['description']),
      validValues: serializer.fromJson<String?>(json['validValues']),
      examples: serializer.fromJson<String?>(json['examples']),
      typeInfo: serializer.fromJson<String?>(json['typeInfo']),
      confidence: serializer.fromJson<double>(json['confidence']),
      parsedAt: serializer.fromJson<DateTime>(json['parsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cacheId': serializer.toJson<int>(cacheId),
      'pluginName': serializer.toJson<String>(pluginName),
      'fieldName': serializer.toJson<String>(fieldName),
      'description': serializer.toJson<String?>(description),
      'validValues': serializer.toJson<String?>(validValues),
      'examples': serializer.toJson<String?>(examples),
      'typeInfo': serializer.toJson<String?>(typeInfo),
      'confidence': serializer.toJson<double>(confidence),
      'parsedAt': serializer.toJson<DateTime>(parsedAt),
    };
  }

  ParsedFieldDocRow copyWith({
    int? id,
    int? cacheId,
    String? pluginName,
    String? fieldName,
    Value<String?> description = const Value.absent(),
    Value<String?> validValues = const Value.absent(),
    Value<String?> examples = const Value.absent(),
    Value<String?> typeInfo = const Value.absent(),
    double? confidence,
    DateTime? parsedAt,
  }) => ParsedFieldDocRow(
    id: id ?? this.id,
    cacheId: cacheId ?? this.cacheId,
    pluginName: pluginName ?? this.pluginName,
    fieldName: fieldName ?? this.fieldName,
    description: description.present ? description.value : this.description,
    validValues: validValues.present ? validValues.value : this.validValues,
    examples: examples.present ? examples.value : this.examples,
    typeInfo: typeInfo.present ? typeInfo.value : this.typeInfo,
    confidence: confidence ?? this.confidence,
    parsedAt: parsedAt ?? this.parsedAt,
  );
  ParsedFieldDocRow copyWithCompanion(ParsedFieldDocTableCompanion data) {
    return ParsedFieldDocRow(
      id: data.id.present ? data.id.value : this.id,
      cacheId: data.cacheId.present ? data.cacheId.value : this.cacheId,
      pluginName: data.pluginName.present
          ? data.pluginName.value
          : this.pluginName,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      description: data.description.present
          ? data.description.value
          : this.description,
      validValues: data.validValues.present
          ? data.validValues.value
          : this.validValues,
      examples: data.examples.present ? data.examples.value : this.examples,
      typeInfo: data.typeInfo.present ? data.typeInfo.value : this.typeInfo,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      parsedAt: data.parsedAt.present ? data.parsedAt.value : this.parsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParsedFieldDocRow(')
          ..write('id: $id, ')
          ..write('cacheId: $cacheId, ')
          ..write('pluginName: $pluginName, ')
          ..write('fieldName: $fieldName, ')
          ..write('description: $description, ')
          ..write('validValues: $validValues, ')
          ..write('examples: $examples, ')
          ..write('typeInfo: $typeInfo, ')
          ..write('confidence: $confidence, ')
          ..write('parsedAt: $parsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cacheId,
    pluginName,
    fieldName,
    description,
    validValues,
    examples,
    typeInfo,
    confidence,
    parsedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParsedFieldDocRow &&
          other.id == this.id &&
          other.cacheId == this.cacheId &&
          other.pluginName == this.pluginName &&
          other.fieldName == this.fieldName &&
          other.description == this.description &&
          other.validValues == this.validValues &&
          other.examples == this.examples &&
          other.typeInfo == this.typeInfo &&
          other.confidence == this.confidence &&
          other.parsedAt == this.parsedAt);
}

class ParsedFieldDocTableCompanion extends UpdateCompanion<ParsedFieldDocRow> {
  final Value<int> id;
  final Value<int> cacheId;
  final Value<String> pluginName;
  final Value<String> fieldName;
  final Value<String?> description;
  final Value<String?> validValues;
  final Value<String?> examples;
  final Value<String?> typeInfo;
  final Value<double> confidence;
  final Value<DateTime> parsedAt;
  const ParsedFieldDocTableCompanion({
    this.id = const Value.absent(),
    this.cacheId = const Value.absent(),
    this.pluginName = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.description = const Value.absent(),
    this.validValues = const Value.absent(),
    this.examples = const Value.absent(),
    this.typeInfo = const Value.absent(),
    this.confidence = const Value.absent(),
    this.parsedAt = const Value.absent(),
  });
  ParsedFieldDocTableCompanion.insert({
    this.id = const Value.absent(),
    required int cacheId,
    required String pluginName,
    required String fieldName,
    this.description = const Value.absent(),
    this.validValues = const Value.absent(),
    this.examples = const Value.absent(),
    this.typeInfo = const Value.absent(),
    this.confidence = const Value.absent(),
    this.parsedAt = const Value.absent(),
  }) : cacheId = Value(cacheId),
       pluginName = Value(pluginName),
       fieldName = Value(fieldName);
  static Insertable<ParsedFieldDocRow> custom({
    Expression<int>? id,
    Expression<int>? cacheId,
    Expression<String>? pluginName,
    Expression<String>? fieldName,
    Expression<String>? description,
    Expression<String>? validValues,
    Expression<String>? examples,
    Expression<String>? typeInfo,
    Expression<double>? confidence,
    Expression<DateTime>? parsedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cacheId != null) 'cache_id': cacheId,
      if (pluginName != null) 'plugin_name': pluginName,
      if (fieldName != null) 'field_name': fieldName,
      if (description != null) 'description': description,
      if (validValues != null) 'valid_values': validValues,
      if (examples != null) 'examples': examples,
      if (typeInfo != null) 'type_info': typeInfo,
      if (confidence != null) 'confidence': confidence,
      if (parsedAt != null) 'parsed_at': parsedAt,
    });
  }

  ParsedFieldDocTableCompanion copyWith({
    Value<int>? id,
    Value<int>? cacheId,
    Value<String>? pluginName,
    Value<String>? fieldName,
    Value<String?>? description,
    Value<String?>? validValues,
    Value<String?>? examples,
    Value<String?>? typeInfo,
    Value<double>? confidence,
    Value<DateTime>? parsedAt,
  }) {
    return ParsedFieldDocTableCompanion(
      id: id ?? this.id,
      cacheId: cacheId ?? this.cacheId,
      pluginName: pluginName ?? this.pluginName,
      fieldName: fieldName ?? this.fieldName,
      description: description ?? this.description,
      validValues: validValues ?? this.validValues,
      examples: examples ?? this.examples,
      typeInfo: typeInfo ?? this.typeInfo,
      confidence: confidence ?? this.confidence,
      parsedAt: parsedAt ?? this.parsedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cacheId.present) {
      map['cache_id'] = Variable<int>(cacheId.value);
    }
    if (pluginName.present) {
      map['plugin_name'] = Variable<String>(pluginName.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (validValues.present) {
      map['valid_values'] = Variable<String>(validValues.value);
    }
    if (examples.present) {
      map['examples'] = Variable<String>(examples.value);
    }
    if (typeInfo.present) {
      map['type_info'] = Variable<String>(typeInfo.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (parsedAt.present) {
      map['parsed_at'] = Variable<DateTime>(parsedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParsedFieldDocTableCompanion(')
          ..write('id: $id, ')
          ..write('cacheId: $cacheId, ')
          ..write('pluginName: $pluginName, ')
          ..write('fieldName: $fieldName, ')
          ..write('description: $description, ')
          ..write('validValues: $validValues, ')
          ..write('examples: $examples, ')
          ..write('typeInfo: $typeInfo, ')
          ..write('confidence: $confidence, ')
          ..write('parsedAt: $parsedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FieldMetadataTableTable fieldMetadataTable =
      $FieldMetadataTableTable(this);
  late final $MetadataConstraintsTableTable metadataConstraintsTable =
      $MetadataConstraintsTableTable(this);
  late final $ConfigPatternsTableTable configPatternsTable =
      $ConfigPatternsTableTable(this);
  late final $PatternFeedbackTableTable patternFeedbackTable =
      $PatternFeedbackTableTable(this);
  late final $FieldStatisticsTableTable fieldStatisticsTable =
      $FieldStatisticsTableTable(this);
  late final $DocumentationSourcesTableTable documentationSourcesTable =
      $DocumentationSourcesTableTable(this);
  late final $DocumentationCacheTableTable documentationCacheTable =
      $DocumentationCacheTableTable(this);
  late final $ParsedFieldDocTableTable parsedFieldDocTable =
      $ParsedFieldDocTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    fieldMetadataTable,
    metadataConstraintsTable,
    configPatternsTable,
    patternFeedbackTable,
    fieldStatisticsTable,
    documentationSourcesTable,
    documentationCacheTable,
    parsedFieldDocTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'field_metadata',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('metadata_constraints', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'config_patterns',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pattern_feedback', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documentation_sources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('documentation_cache', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documentation_cache',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('parsed_field_docs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$FieldMetadataTableTableCreateCompanionBuilder =
    FieldMetadataTableCompanion Function({
      Value<int> id,
      required String fieldPath,
      Value<String?> pluginName,
      Value<String?> configType,
      Value<String?> description,
      Value<String?> tooltip,
      Value<String?> valueType,
      Value<String?> widgetHint,
      Value<String?> allowedValues,
      Value<String?> defaultValue,
      Value<String?> autocompleteSource,
      Value<String?> imagePreviewUrl,
      Value<String?> conditionalField,
      Value<String?> presetName,
      Value<double> confidence,
      Value<String> version,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$FieldMetadataTableTableUpdateCompanionBuilder =
    FieldMetadataTableCompanion Function({
      Value<int> id,
      Value<String> fieldPath,
      Value<String?> pluginName,
      Value<String?> configType,
      Value<String?> description,
      Value<String?> tooltip,
      Value<String?> valueType,
      Value<String?> widgetHint,
      Value<String?> allowedValues,
      Value<String?> defaultValue,
      Value<String?> autocompleteSource,
      Value<String?> imagePreviewUrl,
      Value<String?> conditionalField,
      Value<String?> presetName,
      Value<double> confidence,
      Value<String> version,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$FieldMetadataTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FieldMetadataTableTable,
          FieldMetadataRow
        > {
  $$FieldMetadataTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $MetadataConstraintsTableTable,
    List<MetadataConstraintRow>
  >
  _metadataConstraintsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.metadataConstraintsTable,
        aliasName: $_aliasNameGenerator(
          db.fieldMetadataTable.id,
          db.metadataConstraintsTable.fieldMetadataId,
        ),
      );

  $$MetadataConstraintsTableTableProcessedTableManager
  get metadataConstraintsTableRefs {
    final manager = $$MetadataConstraintsTableTableTableManager(
      $_db,
      $_db.metadataConstraintsTable,
    ).filter((f) => f.fieldMetadataId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _metadataConstraintsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FieldMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $FieldMetadataTableTable> {
  $$FieldMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldPath => $composableBuilder(
    column: $table.fieldPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tooltip => $composableBuilder(
    column: $table.tooltip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get widgetHint => $composableBuilder(
    column: $table.widgetHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allowedValues => $composableBuilder(
    column: $table.allowedValues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultValue => $composableBuilder(
    column: $table.defaultValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get autocompleteSource => $composableBuilder(
    column: $table.autocompleteSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePreviewUrl => $composableBuilder(
    column: $table.imagePreviewUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionalField => $composableBuilder(
    column: $table.conditionalField,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get presetName => $composableBuilder(
    column: $table.presetName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> metadataConstraintsTableRefs(
    Expression<bool> Function($$MetadataConstraintsTableTableFilterComposer f)
    f,
  ) {
    final $$MetadataConstraintsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.metadataConstraintsTable,
          getReferencedColumn: (t) => t.fieldMetadataId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MetadataConstraintsTableTableFilterComposer(
                $db: $db,
                $table: $db.metadataConstraintsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FieldMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldMetadataTableTable> {
  $$FieldMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldPath => $composableBuilder(
    column: $table.fieldPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tooltip => $composableBuilder(
    column: $table.tooltip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get widgetHint => $composableBuilder(
    column: $table.widgetHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allowedValues => $composableBuilder(
    column: $table.allowedValues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultValue => $composableBuilder(
    column: $table.defaultValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get autocompleteSource => $composableBuilder(
    column: $table.autocompleteSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePreviewUrl => $composableBuilder(
    column: $table.imagePreviewUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionalField => $composableBuilder(
    column: $table.conditionalField,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get presetName => $composableBuilder(
    column: $table.presetName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FieldMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldMetadataTableTable> {
  $$FieldMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldPath =>
      $composableBuilder(column: $table.fieldPath, builder: (column) => column);

  GeneratedColumn<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tooltip =>
      $composableBuilder(column: $table.tooltip, builder: (column) => column);

  GeneratedColumn<String> get valueType =>
      $composableBuilder(column: $table.valueType, builder: (column) => column);

  GeneratedColumn<String> get widgetHint => $composableBuilder(
    column: $table.widgetHint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allowedValues => $composableBuilder(
    column: $table.allowedValues,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultValue => $composableBuilder(
    column: $table.defaultValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get autocompleteSource => $composableBuilder(
    column: $table.autocompleteSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePreviewUrl => $composableBuilder(
    column: $table.imagePreviewUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conditionalField => $composableBuilder(
    column: $table.conditionalField,
    builder: (column) => column,
  );

  GeneratedColumn<String> get presetName => $composableBuilder(
    column: $table.presetName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> metadataConstraintsTableRefs<T extends Object>(
    Expression<T> Function($$MetadataConstraintsTableTableAnnotationComposer a)
    f,
  ) {
    final $$MetadataConstraintsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.metadataConstraintsTable,
          getReferencedColumn: (t) => t.fieldMetadataId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MetadataConstraintsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.metadataConstraintsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FieldMetadataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldMetadataTableTable,
          FieldMetadataRow,
          $$FieldMetadataTableTableFilterComposer,
          $$FieldMetadataTableTableOrderingComposer,
          $$FieldMetadataTableTableAnnotationComposer,
          $$FieldMetadataTableTableCreateCompanionBuilder,
          $$FieldMetadataTableTableUpdateCompanionBuilder,
          (FieldMetadataRow, $$FieldMetadataTableTableReferences),
          FieldMetadataRow,
          PrefetchHooks Function({bool metadataConstraintsTableRefs})
        > {
  $$FieldMetadataTableTableTableManager(
    _$AppDatabase db,
    $FieldMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldMetadataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fieldPath = const Value.absent(),
                Value<String?> pluginName = const Value.absent(),
                Value<String?> configType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> tooltip = const Value.absent(),
                Value<String?> valueType = const Value.absent(),
                Value<String?> widgetHint = const Value.absent(),
                Value<String?> allowedValues = const Value.absent(),
                Value<String?> defaultValue = const Value.absent(),
                Value<String?> autocompleteSource = const Value.absent(),
                Value<String?> imagePreviewUrl = const Value.absent(),
                Value<String?> conditionalField = const Value.absent(),
                Value<String?> presetName = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FieldMetadataTableCompanion(
                id: id,
                fieldPath: fieldPath,
                pluginName: pluginName,
                configType: configType,
                description: description,
                tooltip: tooltip,
                valueType: valueType,
                widgetHint: widgetHint,
                allowedValues: allowedValues,
                defaultValue: defaultValue,
                autocompleteSource: autocompleteSource,
                imagePreviewUrl: imagePreviewUrl,
                conditionalField: conditionalField,
                presetName: presetName,
                confidence: confidence,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fieldPath,
                Value<String?> pluginName = const Value.absent(),
                Value<String?> configType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> tooltip = const Value.absent(),
                Value<String?> valueType = const Value.absent(),
                Value<String?> widgetHint = const Value.absent(),
                Value<String?> allowedValues = const Value.absent(),
                Value<String?> defaultValue = const Value.absent(),
                Value<String?> autocompleteSource = const Value.absent(),
                Value<String?> imagePreviewUrl = const Value.absent(),
                Value<String?> conditionalField = const Value.absent(),
                Value<String?> presetName = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FieldMetadataTableCompanion.insert(
                id: id,
                fieldPath: fieldPath,
                pluginName: pluginName,
                configType: configType,
                description: description,
                tooltip: tooltip,
                valueType: valueType,
                widgetHint: widgetHint,
                allowedValues: allowedValues,
                defaultValue: defaultValue,
                autocompleteSource: autocompleteSource,
                imagePreviewUrl: imagePreviewUrl,
                conditionalField: conditionalField,
                presetName: presetName,
                confidence: confidence,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FieldMetadataTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({metadataConstraintsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (metadataConstraintsTableRefs) db.metadataConstraintsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (metadataConstraintsTableRefs)
                    await $_getPrefetchedData<
                      FieldMetadataRow,
                      $FieldMetadataTableTable,
                      MetadataConstraintRow
                    >(
                      currentTable: table,
                      referencedTable: $$FieldMetadataTableTableReferences
                          ._metadataConstraintsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FieldMetadataTableTableReferences(
                            db,
                            table,
                            p0,
                          ).metadataConstraintsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.fieldMetadataId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FieldMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldMetadataTableTable,
      FieldMetadataRow,
      $$FieldMetadataTableTableFilterComposer,
      $$FieldMetadataTableTableOrderingComposer,
      $$FieldMetadataTableTableAnnotationComposer,
      $$FieldMetadataTableTableCreateCompanionBuilder,
      $$FieldMetadataTableTableUpdateCompanionBuilder,
      (FieldMetadataRow, $$FieldMetadataTableTableReferences),
      FieldMetadataRow,
      PrefetchHooks Function({bool metadataConstraintsTableRefs})
    >;
typedef $$MetadataConstraintsTableTableCreateCompanionBuilder =
    MetadataConstraintsTableCompanion Function({
      Value<int> id,
      required int fieldMetadataId,
      required String constraintType,
      required String value,
      Value<String?> errorMessage,
    });
typedef $$MetadataConstraintsTableTableUpdateCompanionBuilder =
    MetadataConstraintsTableCompanion Function({
      Value<int> id,
      Value<int> fieldMetadataId,
      Value<String> constraintType,
      Value<String> value,
      Value<String?> errorMessage,
    });

final class $$MetadataConstraintsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MetadataConstraintsTableTable,
          MetadataConstraintRow
        > {
  $$MetadataConstraintsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FieldMetadataTableTable _fieldMetadataIdTable(_$AppDatabase db) =>
      db.fieldMetadataTable.createAlias(
        $_aliasNameGenerator(
          db.metadataConstraintsTable.fieldMetadataId,
          db.fieldMetadataTable.id,
        ),
      );

  $$FieldMetadataTableTableProcessedTableManager get fieldMetadataId {
    final $_column = $_itemColumn<int>('field_metadata_id')!;

    final manager = $$FieldMetadataTableTableTableManager(
      $_db,
      $_db.fieldMetadataTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fieldMetadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MetadataConstraintsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MetadataConstraintsTableTable> {
  $$MetadataConstraintsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get constraintType => $composableBuilder(
    column: $table.constraintType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  $$FieldMetadataTableTableFilterComposer get fieldMetadataId {
    final $$FieldMetadataTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldMetadataId,
      referencedTable: $db.fieldMetadataTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldMetadataTableTableFilterComposer(
            $db: $db,
            $table: $db.fieldMetadataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetadataConstraintsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MetadataConstraintsTableTable> {
  $$MetadataConstraintsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get constraintType => $composableBuilder(
    column: $table.constraintType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  $$FieldMetadataTableTableOrderingComposer get fieldMetadataId {
    final $$FieldMetadataTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fieldMetadataId,
      referencedTable: $db.fieldMetadataTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FieldMetadataTableTableOrderingComposer(
            $db: $db,
            $table: $db.fieldMetadataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetadataConstraintsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetadataConstraintsTableTable> {
  $$MetadataConstraintsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get constraintType => $composableBuilder(
    column: $table.constraintType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  $$FieldMetadataTableTableAnnotationComposer get fieldMetadataId {
    final $$FieldMetadataTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.fieldMetadataId,
          referencedTable: $db.fieldMetadataTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FieldMetadataTableTableAnnotationComposer(
                $db: $db,
                $table: $db.fieldMetadataTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MetadataConstraintsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetadataConstraintsTableTable,
          MetadataConstraintRow,
          $$MetadataConstraintsTableTableFilterComposer,
          $$MetadataConstraintsTableTableOrderingComposer,
          $$MetadataConstraintsTableTableAnnotationComposer,
          $$MetadataConstraintsTableTableCreateCompanionBuilder,
          $$MetadataConstraintsTableTableUpdateCompanionBuilder,
          (MetadataConstraintRow, $$MetadataConstraintsTableTableReferences),
          MetadataConstraintRow,
          PrefetchHooks Function({bool fieldMetadataId})
        > {
  $$MetadataConstraintsTableTableTableManager(
    _$AppDatabase db,
    $MetadataConstraintsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetadataConstraintsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MetadataConstraintsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MetadataConstraintsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fieldMetadataId = const Value.absent(),
                Value<String> constraintType = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
              }) => MetadataConstraintsTableCompanion(
                id: id,
                fieldMetadataId: fieldMetadataId,
                constraintType: constraintType,
                value: value,
                errorMessage: errorMessage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fieldMetadataId,
                required String constraintType,
                required String value,
                Value<String?> errorMessage = const Value.absent(),
              }) => MetadataConstraintsTableCompanion.insert(
                id: id,
                fieldMetadataId: fieldMetadataId,
                constraintType: constraintType,
                value: value,
                errorMessage: errorMessage,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MetadataConstraintsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fieldMetadataId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fieldMetadataId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fieldMetadataId,
                                referencedTable:
                                    $$MetadataConstraintsTableTableReferences
                                        ._fieldMetadataIdTable(db),
                                referencedColumn:
                                    $$MetadataConstraintsTableTableReferences
                                        ._fieldMetadataIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MetadataConstraintsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetadataConstraintsTableTable,
      MetadataConstraintRow,
      $$MetadataConstraintsTableTableFilterComposer,
      $$MetadataConstraintsTableTableOrderingComposer,
      $$MetadataConstraintsTableTableAnnotationComposer,
      $$MetadataConstraintsTableTableCreateCompanionBuilder,
      $$MetadataConstraintsTableTableUpdateCompanionBuilder,
      (MetadataConstraintRow, $$MetadataConstraintsTableTableReferences),
      MetadataConstraintRow,
      PrefetchHooks Function({bool fieldMetadataId})
    >;
typedef $$ConfigPatternsTableTableCreateCompanionBuilder =
    ConfigPatternsTableCompanion Function({
      required String id,
      required String fieldName,
      Value<String?> pluginName,
      Value<String?> configType,
      required double confidence,
      Value<int> occurrences,
      required DateTime lastSeen,
      Value<DateTime> createdAt,
      Value<int?> metadataId,
      Value<int> rowid,
    });
typedef $$ConfigPatternsTableTableUpdateCompanionBuilder =
    ConfigPatternsTableCompanion Function({
      Value<String> id,
      Value<String> fieldName,
      Value<String?> pluginName,
      Value<String?> configType,
      Value<double> confidence,
      Value<int> occurrences,
      Value<DateTime> lastSeen,
      Value<DateTime> createdAt,
      Value<int?> metadataId,
      Value<int> rowid,
    });

final class $$ConfigPatternsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ConfigPatternsTableTable,
          ConfigPatternRow
        > {
  $$ConfigPatternsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PatternFeedbackTableTable,
    List<PatternFeedbackRow>
  >
  _patternFeedbackTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.patternFeedbackTable,
        aliasName: $_aliasNameGenerator(
          db.configPatternsTable.id,
          db.patternFeedbackTable.patternId,
        ),
      );

  $$PatternFeedbackTableTableProcessedTableManager
  get patternFeedbackTableRefs {
    final manager = $$PatternFeedbackTableTableTableManager(
      $_db,
      $_db.patternFeedbackTable,
    ).filter((f) => f.patternId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _patternFeedbackTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ConfigPatternsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConfigPatternsTableTable> {
  $$ConfigPatternsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get metadataId => $composableBuilder(
    column: $table.metadataId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> patternFeedbackTableRefs(
    Expression<bool> Function($$PatternFeedbackTableTableFilterComposer f) f,
  ) {
    final $$PatternFeedbackTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patternFeedbackTable,
      getReferencedColumn: (t) => t.patternId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatternFeedbackTableTableFilterComposer(
            $db: $db,
            $table: $db.patternFeedbackTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ConfigPatternsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfigPatternsTableTable> {
  $$ConfigPatternsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get metadataId => $composableBuilder(
    column: $table.metadataId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConfigPatternsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfigPatternsTableTable> {
  $$ConfigPatternsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get metadataId => $composableBuilder(
    column: $table.metadataId,
    builder: (column) => column,
  );

  Expression<T> patternFeedbackTableRefs<T extends Object>(
    Expression<T> Function($$PatternFeedbackTableTableAnnotationComposer a) f,
  ) {
    final $$PatternFeedbackTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.patternFeedbackTable,
          getReferencedColumn: (t) => t.patternId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PatternFeedbackTableTableAnnotationComposer(
                $db: $db,
                $table: $db.patternFeedbackTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ConfigPatternsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfigPatternsTableTable,
          ConfigPatternRow,
          $$ConfigPatternsTableTableFilterComposer,
          $$ConfigPatternsTableTableOrderingComposer,
          $$ConfigPatternsTableTableAnnotationComposer,
          $$ConfigPatternsTableTableCreateCompanionBuilder,
          $$ConfigPatternsTableTableUpdateCompanionBuilder,
          (ConfigPatternRow, $$ConfigPatternsTableTableReferences),
          ConfigPatternRow,
          PrefetchHooks Function({bool patternFeedbackTableRefs})
        > {
  $$ConfigPatternsTableTableTableManager(
    _$AppDatabase db,
    $ConfigPatternsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfigPatternsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfigPatternsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ConfigPatternsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<String?> pluginName = const Value.absent(),
                Value<String?> configType = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<int> occurrences = const Value.absent(),
                Value<DateTime> lastSeen = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int?> metadataId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfigPatternsTableCompanion(
                id: id,
                fieldName: fieldName,
                pluginName: pluginName,
                configType: configType,
                confidence: confidence,
                occurrences: occurrences,
                lastSeen: lastSeen,
                createdAt: createdAt,
                metadataId: metadataId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fieldName,
                Value<String?> pluginName = const Value.absent(),
                Value<String?> configType = const Value.absent(),
                required double confidence,
                Value<int> occurrences = const Value.absent(),
                required DateTime lastSeen,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int?> metadataId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfigPatternsTableCompanion.insert(
                id: id,
                fieldName: fieldName,
                pluginName: pluginName,
                configType: configType,
                confidence: confidence,
                occurrences: occurrences,
                lastSeen: lastSeen,
                createdAt: createdAt,
                metadataId: metadataId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConfigPatternsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patternFeedbackTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (patternFeedbackTableRefs) db.patternFeedbackTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (patternFeedbackTableRefs)
                    await $_getPrefetchedData<
                      ConfigPatternRow,
                      $ConfigPatternsTableTable,
                      PatternFeedbackRow
                    >(
                      currentTable: table,
                      referencedTable: $$ConfigPatternsTableTableReferences
                          ._patternFeedbackTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ConfigPatternsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).patternFeedbackTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.patternId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ConfigPatternsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfigPatternsTableTable,
      ConfigPatternRow,
      $$ConfigPatternsTableTableFilterComposer,
      $$ConfigPatternsTableTableOrderingComposer,
      $$ConfigPatternsTableTableAnnotationComposer,
      $$ConfigPatternsTableTableCreateCompanionBuilder,
      $$ConfigPatternsTableTableUpdateCompanionBuilder,
      (ConfigPatternRow, $$ConfigPatternsTableTableReferences),
      ConfigPatternRow,
      PrefetchHooks Function({bool patternFeedbackTableRefs})
    >;
typedef $$PatternFeedbackTableTableCreateCompanionBuilder =
    PatternFeedbackTableCompanion Function({
      Value<int> id,
      required String patternId,
      required bool accepted,
      Value<String?> userModification,
      Value<DateTime> feedbackAt,
    });
typedef $$PatternFeedbackTableTableUpdateCompanionBuilder =
    PatternFeedbackTableCompanion Function({
      Value<int> id,
      Value<String> patternId,
      Value<bool> accepted,
      Value<String?> userModification,
      Value<DateTime> feedbackAt,
    });

final class $$PatternFeedbackTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PatternFeedbackTableTable,
          PatternFeedbackRow
        > {
  $$PatternFeedbackTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ConfigPatternsTableTable _patternIdTable(_$AppDatabase db) =>
      db.configPatternsTable.createAlias(
        $_aliasNameGenerator(
          db.patternFeedbackTable.patternId,
          db.configPatternsTable.id,
        ),
      );

  $$ConfigPatternsTableTableProcessedTableManager get patternId {
    final $_column = $_itemColumn<String>('pattern_id')!;

    final manager = $$ConfigPatternsTableTableTableManager(
      $_db,
      $_db.configPatternsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patternIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PatternFeedbackTableTableFilterComposer
    extends Composer<_$AppDatabase, $PatternFeedbackTableTable> {
  $$PatternFeedbackTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get accepted => $composableBuilder(
    column: $table.accepted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userModification => $composableBuilder(
    column: $table.userModification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get feedbackAt => $composableBuilder(
    column: $table.feedbackAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ConfigPatternsTableTableFilterComposer get patternId {
    final $$ConfigPatternsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.configPatternsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConfigPatternsTableTableFilterComposer(
            $db: $db,
            $table: $db.configPatternsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PatternFeedbackTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PatternFeedbackTableTable> {
  $$PatternFeedbackTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get accepted => $composableBuilder(
    column: $table.accepted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userModification => $composableBuilder(
    column: $table.userModification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get feedbackAt => $composableBuilder(
    column: $table.feedbackAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ConfigPatternsTableTableOrderingComposer get patternId {
    final $$ConfigPatternsTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.patternId,
          referencedTable: $db.configPatternsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ConfigPatternsTableTableOrderingComposer(
                $db: $db,
                $table: $db.configPatternsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PatternFeedbackTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatternFeedbackTableTable> {
  $$PatternFeedbackTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get accepted =>
      $composableBuilder(column: $table.accepted, builder: (column) => column);

  GeneratedColumn<String> get userModification => $composableBuilder(
    column: $table.userModification,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get feedbackAt => $composableBuilder(
    column: $table.feedbackAt,
    builder: (column) => column,
  );

  $$ConfigPatternsTableTableAnnotationComposer get patternId {
    final $$ConfigPatternsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.patternId,
          referencedTable: $db.configPatternsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ConfigPatternsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.configPatternsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PatternFeedbackTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatternFeedbackTableTable,
          PatternFeedbackRow,
          $$PatternFeedbackTableTableFilterComposer,
          $$PatternFeedbackTableTableOrderingComposer,
          $$PatternFeedbackTableTableAnnotationComposer,
          $$PatternFeedbackTableTableCreateCompanionBuilder,
          $$PatternFeedbackTableTableUpdateCompanionBuilder,
          (PatternFeedbackRow, $$PatternFeedbackTableTableReferences),
          PatternFeedbackRow,
          PrefetchHooks Function({bool patternId})
        > {
  $$PatternFeedbackTableTableTableManager(
    _$AppDatabase db,
    $PatternFeedbackTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatternFeedbackTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatternFeedbackTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PatternFeedbackTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> patternId = const Value.absent(),
                Value<bool> accepted = const Value.absent(),
                Value<String?> userModification = const Value.absent(),
                Value<DateTime> feedbackAt = const Value.absent(),
              }) => PatternFeedbackTableCompanion(
                id: id,
                patternId: patternId,
                accepted: accepted,
                userModification: userModification,
                feedbackAt: feedbackAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String patternId,
                required bool accepted,
                Value<String?> userModification = const Value.absent(),
                Value<DateTime> feedbackAt = const Value.absent(),
              }) => PatternFeedbackTableCompanion.insert(
                id: id,
                patternId: patternId,
                accepted: accepted,
                userModification: userModification,
                feedbackAt: feedbackAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PatternFeedbackTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patternId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (patternId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.patternId,
                                referencedTable:
                                    $$PatternFeedbackTableTableReferences
                                        ._patternIdTable(db),
                                referencedColumn:
                                    $$PatternFeedbackTableTableReferences
                                        ._patternIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PatternFeedbackTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatternFeedbackTableTable,
      PatternFeedbackRow,
      $$PatternFeedbackTableTableFilterComposer,
      $$PatternFeedbackTableTableOrderingComposer,
      $$PatternFeedbackTableTableAnnotationComposer,
      $$PatternFeedbackTableTableCreateCompanionBuilder,
      $$PatternFeedbackTableTableUpdateCompanionBuilder,
      (PatternFeedbackRow, $$PatternFeedbackTableTableReferences),
      PatternFeedbackRow,
      PrefetchHooks Function({bool patternId})
    >;
typedef $$FieldStatisticsTableTableCreateCompanionBuilder =
    FieldStatisticsTableCompanion Function({
      Value<int> id,
      required String fieldName,
      Value<String?> pluginName,
      Value<String?> configType,
      Value<String?> commonValueType,
      Value<String?> minValue,
      Value<String?> maxValue,
      Value<String?> enumValues,
      Value<int> frequency,
      required DateTime lastSeen,
      Value<DateTime> createdAt,
    });
typedef $$FieldStatisticsTableTableUpdateCompanionBuilder =
    FieldStatisticsTableCompanion Function({
      Value<int> id,
      Value<String> fieldName,
      Value<String?> pluginName,
      Value<String?> configType,
      Value<String?> commonValueType,
      Value<String?> minValue,
      Value<String?> maxValue,
      Value<String?> enumValues,
      Value<int> frequency,
      Value<DateTime> lastSeen,
      Value<DateTime> createdAt,
    });

class $$FieldStatisticsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FieldStatisticsTableTable> {
  $$FieldStatisticsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonValueType => $composableBuilder(
    column: $table.commonValueType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get minValue => $composableBuilder(
    column: $table.minValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maxValue => $composableBuilder(
    column: $table.maxValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enumValues => $composableBuilder(
    column: $table.enumValues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FieldStatisticsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldStatisticsTableTable> {
  $$FieldStatisticsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonValueType => $composableBuilder(
    column: $table.commonValueType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get minValue => $composableBuilder(
    column: $table.minValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maxValue => $composableBuilder(
    column: $table.maxValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enumValues => $composableBuilder(
    column: $table.enumValues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FieldStatisticsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldStatisticsTableTable> {
  $$FieldStatisticsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get configType => $composableBuilder(
    column: $table.configType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commonValueType => $composableBuilder(
    column: $table.commonValueType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get minValue =>
      $composableBuilder(column: $table.minValue, builder: (column) => column);

  GeneratedColumn<String> get maxValue =>
      $composableBuilder(column: $table.maxValue, builder: (column) => column);

  GeneratedColumn<String> get enumValues => $composableBuilder(
    column: $table.enumValues,
    builder: (column) => column,
  );

  GeneratedColumn<int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FieldStatisticsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldStatisticsTableTable,
          FieldStatisticsRow,
          $$FieldStatisticsTableTableFilterComposer,
          $$FieldStatisticsTableTableOrderingComposer,
          $$FieldStatisticsTableTableAnnotationComposer,
          $$FieldStatisticsTableTableCreateCompanionBuilder,
          $$FieldStatisticsTableTableUpdateCompanionBuilder,
          (
            FieldStatisticsRow,
            BaseReferences<
              _$AppDatabase,
              $FieldStatisticsTableTable,
              FieldStatisticsRow
            >,
          ),
          FieldStatisticsRow,
          PrefetchHooks Function()
        > {
  $$FieldStatisticsTableTableTableManager(
    _$AppDatabase db,
    $FieldStatisticsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldStatisticsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldStatisticsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FieldStatisticsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<String?> pluginName = const Value.absent(),
                Value<String?> configType = const Value.absent(),
                Value<String?> commonValueType = const Value.absent(),
                Value<String?> minValue = const Value.absent(),
                Value<String?> maxValue = const Value.absent(),
                Value<String?> enumValues = const Value.absent(),
                Value<int> frequency = const Value.absent(),
                Value<DateTime> lastSeen = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FieldStatisticsTableCompanion(
                id: id,
                fieldName: fieldName,
                pluginName: pluginName,
                configType: configType,
                commonValueType: commonValueType,
                minValue: minValue,
                maxValue: maxValue,
                enumValues: enumValues,
                frequency: frequency,
                lastSeen: lastSeen,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fieldName,
                Value<String?> pluginName = const Value.absent(),
                Value<String?> configType = const Value.absent(),
                Value<String?> commonValueType = const Value.absent(),
                Value<String?> minValue = const Value.absent(),
                Value<String?> maxValue = const Value.absent(),
                Value<String?> enumValues = const Value.absent(),
                Value<int> frequency = const Value.absent(),
                required DateTime lastSeen,
                Value<DateTime> createdAt = const Value.absent(),
              }) => FieldStatisticsTableCompanion.insert(
                id: id,
                fieldName: fieldName,
                pluginName: pluginName,
                configType: configType,
                commonValueType: commonValueType,
                minValue: minValue,
                maxValue: maxValue,
                enumValues: enumValues,
                frequency: frequency,
                lastSeen: lastSeen,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FieldStatisticsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldStatisticsTableTable,
      FieldStatisticsRow,
      $$FieldStatisticsTableTableFilterComposer,
      $$FieldStatisticsTableTableOrderingComposer,
      $$FieldStatisticsTableTableAnnotationComposer,
      $$FieldStatisticsTableTableCreateCompanionBuilder,
      $$FieldStatisticsTableTableUpdateCompanionBuilder,
      (
        FieldStatisticsRow,
        BaseReferences<
          _$AppDatabase,
          $FieldStatisticsTableTable,
          FieldStatisticsRow
        >,
      ),
      FieldStatisticsRow,
      PrefetchHooks Function()
    >;
typedef $$DocumentationSourcesTableTableCreateCompanionBuilder =
    DocumentationSourcesTableCompanion Function({
      Value<int> id,
      required String pluginName,
      required String sourceType,
      required String url,
      Value<int> priority,
      Value<bool> enabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$DocumentationSourcesTableTableUpdateCompanionBuilder =
    DocumentationSourcesTableCompanion Function({
      Value<int> id,
      Value<String> pluginName,
      Value<String> sourceType,
      Value<String> url,
      Value<int> priority,
      Value<bool> enabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$DocumentationSourcesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DocumentationSourcesTableTable,
          DocumentationSourceRow
        > {
  $$DocumentationSourcesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $DocumentationCacheTableTable,
    List<DocumentationCacheRow>
  >
  _documentationCacheTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentationCacheTable,
        aliasName: $_aliasNameGenerator(
          db.documentationSourcesTable.id,
          db.documentationCacheTable.sourceId,
        ),
      );

  $$DocumentationCacheTableTableProcessedTableManager
  get documentationCacheTableRefs {
    final manager = $$DocumentationCacheTableTableTableManager(
      $_db,
      $_db.documentationCacheTable,
    ).filter((f) => f.sourceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _documentationCacheTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentationSourcesTableTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentationSourcesTableTable> {
  $$DocumentationSourcesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> documentationCacheTableRefs(
    Expression<bool> Function($$DocumentationCacheTableTableFilterComposer f) f,
  ) {
    final $$DocumentationCacheTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.documentationCacheTable,
          getReferencedColumn: (t) => t.sourceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationCacheTableTableFilterComposer(
                $db: $db,
                $table: $db.documentationCacheTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DocumentationSourcesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentationSourcesTableTable> {
  $$DocumentationSourcesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentationSourcesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentationSourcesTableTable> {
  $$DocumentationSourcesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> documentationCacheTableRefs<T extends Object>(
    Expression<T> Function($$DocumentationCacheTableTableAnnotationComposer a)
    f,
  ) {
    final $$DocumentationCacheTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.documentationCacheTable,
          getReferencedColumn: (t) => t.sourceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationCacheTableTableAnnotationComposer(
                $db: $db,
                $table: $db.documentationCacheTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DocumentationSourcesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentationSourcesTableTable,
          DocumentationSourceRow,
          $$DocumentationSourcesTableTableFilterComposer,
          $$DocumentationSourcesTableTableOrderingComposer,
          $$DocumentationSourcesTableTableAnnotationComposer,
          $$DocumentationSourcesTableTableCreateCompanionBuilder,
          $$DocumentationSourcesTableTableUpdateCompanionBuilder,
          (DocumentationSourceRow, $$DocumentationSourcesTableTableReferences),
          DocumentationSourceRow,
          PrefetchHooks Function({bool documentationCacheTableRefs})
        > {
  $$DocumentationSourcesTableTableTableManager(
    _$AppDatabase db,
    $DocumentationSourcesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentationSourcesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DocumentationSourcesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DocumentationSourcesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> pluginName = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DocumentationSourcesTableCompanion(
                id: id,
                pluginName: pluginName,
                sourceType: sourceType,
                url: url,
                priority: priority,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String pluginName,
                required String sourceType,
                required String url,
                Value<int> priority = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DocumentationSourcesTableCompanion.insert(
                id: id,
                pluginName: pluginName,
                sourceType: sourceType,
                url: url,
                priority: priority,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentationSourcesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentationCacheTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (documentationCacheTableRefs) db.documentationCacheTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (documentationCacheTableRefs)
                    await $_getPrefetchedData<
                      DocumentationSourceRow,
                      $DocumentationSourcesTableTable,
                      DocumentationCacheRow
                    >(
                      currentTable: table,
                      referencedTable:
                          $$DocumentationSourcesTableTableReferences
                              ._documentationCacheTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DocumentationSourcesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).documentationCacheTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sourceId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DocumentationSourcesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentationSourcesTableTable,
      DocumentationSourceRow,
      $$DocumentationSourcesTableTableFilterComposer,
      $$DocumentationSourcesTableTableOrderingComposer,
      $$DocumentationSourcesTableTableAnnotationComposer,
      $$DocumentationSourcesTableTableCreateCompanionBuilder,
      $$DocumentationSourcesTableTableUpdateCompanionBuilder,
      (DocumentationSourceRow, $$DocumentationSourcesTableTableReferences),
      DocumentationSourceRow,
      PrefetchHooks Function({bool documentationCacheTableRefs})
    >;
typedef $$DocumentationCacheTableTableCreateCompanionBuilder =
    DocumentationCacheTableCompanion Function({
      Value<int> id,
      required int sourceId,
      required String url,
      required String content,
      Value<String> contentType,
      Value<DateTime> fetchedAt,
      required DateTime expiresAt,
      Value<String?> etag,
    });
typedef $$DocumentationCacheTableTableUpdateCompanionBuilder =
    DocumentationCacheTableCompanion Function({
      Value<int> id,
      Value<int> sourceId,
      Value<String> url,
      Value<String> content,
      Value<String> contentType,
      Value<DateTime> fetchedAt,
      Value<DateTime> expiresAt,
      Value<String?> etag,
    });

final class $$DocumentationCacheTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DocumentationCacheTableTable,
          DocumentationCacheRow
        > {
  $$DocumentationCacheTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentationSourcesTableTable _sourceIdTable(_$AppDatabase db) =>
      db.documentationSourcesTable.createAlias(
        $_aliasNameGenerator(
          db.documentationCacheTable.sourceId,
          db.documentationSourcesTable.id,
        ),
      );

  $$DocumentationSourcesTableTableProcessedTableManager get sourceId {
    final $_column = $_itemColumn<int>('source_id')!;

    final manager = $$DocumentationSourcesTableTableTableManager(
      $_db,
      $_db.documentationSourcesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ParsedFieldDocTableTable, List<ParsedFieldDocRow>>
  _parsedFieldDocTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.parsedFieldDocTable,
        aliasName: $_aliasNameGenerator(
          db.documentationCacheTable.id,
          db.parsedFieldDocTable.cacheId,
        ),
      );

  $$ParsedFieldDocTableTableProcessedTableManager get parsedFieldDocTableRefs {
    final manager = $$ParsedFieldDocTableTableTableManager(
      $_db,
      $_db.parsedFieldDocTable,
    ).filter((f) => f.cacheId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _parsedFieldDocTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentationCacheTableTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentationCacheTableTable> {
  $$DocumentationCacheTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentationSourcesTableTableFilterComposer get sourceId {
    final $$DocumentationSourcesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sourceId,
          referencedTable: $db.documentationSourcesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationSourcesTableTableFilterComposer(
                $db: $db,
                $table: $db.documentationSourcesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> parsedFieldDocTableRefs(
    Expression<bool> Function($$ParsedFieldDocTableTableFilterComposer f) f,
  ) {
    final $$ParsedFieldDocTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parsedFieldDocTable,
      getReferencedColumn: (t) => t.cacheId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParsedFieldDocTableTableFilterComposer(
            $db: $db,
            $table: $db.parsedFieldDocTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentationCacheTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentationCacheTableTable> {
  $$DocumentationCacheTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentationSourcesTableTableOrderingComposer get sourceId {
    final $$DocumentationSourcesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sourceId,
          referencedTable: $db.documentationSourcesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationSourcesTableTableOrderingComposer(
                $db: $db,
                $table: $db.documentationSourcesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$DocumentationCacheTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentationCacheTableTable> {
  $$DocumentationCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  $$DocumentationSourcesTableTableAnnotationComposer get sourceId {
    final $$DocumentationSourcesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sourceId,
          referencedTable: $db.documentationSourcesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationSourcesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.documentationSourcesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> parsedFieldDocTableRefs<T extends Object>(
    Expression<T> Function($$ParsedFieldDocTableTableAnnotationComposer a) f,
  ) {
    final $$ParsedFieldDocTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.parsedFieldDocTable,
          getReferencedColumn: (t) => t.cacheId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParsedFieldDocTableTableAnnotationComposer(
                $db: $db,
                $table: $db.parsedFieldDocTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DocumentationCacheTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentationCacheTableTable,
          DocumentationCacheRow,
          $$DocumentationCacheTableTableFilterComposer,
          $$DocumentationCacheTableTableOrderingComposer,
          $$DocumentationCacheTableTableAnnotationComposer,
          $$DocumentationCacheTableTableCreateCompanionBuilder,
          $$DocumentationCacheTableTableUpdateCompanionBuilder,
          (DocumentationCacheRow, $$DocumentationCacheTableTableReferences),
          DocumentationCacheRow,
          PrefetchHooks Function({bool sourceId, bool parsedFieldDocTableRefs})
        > {
  $$DocumentationCacheTableTableTableManager(
    _$AppDatabase db,
    $DocumentationCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentationCacheTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DocumentationCacheTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DocumentationCacheTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sourceId = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<String?> etag = const Value.absent(),
              }) => DocumentationCacheTableCompanion(
                id: id,
                sourceId: sourceId,
                url: url,
                content: content,
                contentType: contentType,
                fetchedAt: fetchedAt,
                expiresAt: expiresAt,
                etag: etag,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sourceId,
                required String url,
                required String content,
                Value<String> contentType = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                required DateTime expiresAt,
                Value<String?> etag = const Value.absent(),
              }) => DocumentationCacheTableCompanion.insert(
                id: id,
                sourceId: sourceId,
                url: url,
                content: content,
                contentType: contentType,
                fetchedAt: fetchedAt,
                expiresAt: expiresAt,
                etag: etag,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentationCacheTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sourceId = false, parsedFieldDocTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (parsedFieldDocTableRefs) db.parsedFieldDocTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sourceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceId,
                                    referencedTable:
                                        $$DocumentationCacheTableTableReferences
                                            ._sourceIdTable(db),
                                    referencedColumn:
                                        $$DocumentationCacheTableTableReferences
                                            ._sourceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (parsedFieldDocTableRefs)
                        await $_getPrefetchedData<
                          DocumentationCacheRow,
                          $DocumentationCacheTableTable,
                          ParsedFieldDocRow
                        >(
                          currentTable: table,
                          referencedTable:
                              $$DocumentationCacheTableTableReferences
                                  ._parsedFieldDocTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentationCacheTableTableReferences(
                                db,
                                table,
                                p0,
                              ).parsedFieldDocTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cacheId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DocumentationCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentationCacheTableTable,
      DocumentationCacheRow,
      $$DocumentationCacheTableTableFilterComposer,
      $$DocumentationCacheTableTableOrderingComposer,
      $$DocumentationCacheTableTableAnnotationComposer,
      $$DocumentationCacheTableTableCreateCompanionBuilder,
      $$DocumentationCacheTableTableUpdateCompanionBuilder,
      (DocumentationCacheRow, $$DocumentationCacheTableTableReferences),
      DocumentationCacheRow,
      PrefetchHooks Function({bool sourceId, bool parsedFieldDocTableRefs})
    >;
typedef $$ParsedFieldDocTableTableCreateCompanionBuilder =
    ParsedFieldDocTableCompanion Function({
      Value<int> id,
      required int cacheId,
      required String pluginName,
      required String fieldName,
      Value<String?> description,
      Value<String?> validValues,
      Value<String?> examples,
      Value<String?> typeInfo,
      Value<double> confidence,
      Value<DateTime> parsedAt,
    });
typedef $$ParsedFieldDocTableTableUpdateCompanionBuilder =
    ParsedFieldDocTableCompanion Function({
      Value<int> id,
      Value<int> cacheId,
      Value<String> pluginName,
      Value<String> fieldName,
      Value<String?> description,
      Value<String?> validValues,
      Value<String?> examples,
      Value<String?> typeInfo,
      Value<double> confidence,
      Value<DateTime> parsedAt,
    });

final class $$ParsedFieldDocTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ParsedFieldDocTableTable,
          ParsedFieldDocRow
        > {
  $$ParsedFieldDocTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentationCacheTableTable _cacheIdTable(_$AppDatabase db) =>
      db.documentationCacheTable.createAlias(
        $_aliasNameGenerator(
          db.parsedFieldDocTable.cacheId,
          db.documentationCacheTable.id,
        ),
      );

  $$DocumentationCacheTableTableProcessedTableManager get cacheId {
    final $_column = $_itemColumn<int>('cache_id')!;

    final manager = $$DocumentationCacheTableTableTableManager(
      $_db,
      $_db.documentationCacheTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cacheIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParsedFieldDocTableTableFilterComposer
    extends Composer<_$AppDatabase, $ParsedFieldDocTableTable> {
  $$ParsedFieldDocTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validValues => $composableBuilder(
    column: $table.validValues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examples => $composableBuilder(
    column: $table.examples,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeInfo => $composableBuilder(
    column: $table.typeInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get parsedAt => $composableBuilder(
    column: $table.parsedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentationCacheTableTableFilterComposer get cacheId {
    final $$DocumentationCacheTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.cacheId,
          referencedTable: $db.documentationCacheTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationCacheTableTableFilterComposer(
                $db: $db,
                $table: $db.documentationCacheTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ParsedFieldDocTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ParsedFieldDocTableTable> {
  $$ParsedFieldDocTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validValues => $composableBuilder(
    column: $table.validValues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examples => $composableBuilder(
    column: $table.examples,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeInfo => $composableBuilder(
    column: $table.typeInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get parsedAt => $composableBuilder(
    column: $table.parsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentationCacheTableTableOrderingComposer get cacheId {
    final $$DocumentationCacheTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.cacheId,
          referencedTable: $db.documentationCacheTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationCacheTableTableOrderingComposer(
                $db: $db,
                $table: $db.documentationCacheTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ParsedFieldDocTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParsedFieldDocTableTable> {
  $$ParsedFieldDocTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pluginName => $composableBuilder(
    column: $table.pluginName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get validValues => $composableBuilder(
    column: $table.validValues,
    builder: (column) => column,
  );

  GeneratedColumn<String> get examples =>
      $composableBuilder(column: $table.examples, builder: (column) => column);

  GeneratedColumn<String> get typeInfo =>
      $composableBuilder(column: $table.typeInfo, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get parsedAt =>
      $composableBuilder(column: $table.parsedAt, builder: (column) => column);

  $$DocumentationCacheTableTableAnnotationComposer get cacheId {
    final $$DocumentationCacheTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.cacheId,
          referencedTable: $db.documentationCacheTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentationCacheTableTableAnnotationComposer(
                $db: $db,
                $table: $db.documentationCacheTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ParsedFieldDocTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParsedFieldDocTableTable,
          ParsedFieldDocRow,
          $$ParsedFieldDocTableTableFilterComposer,
          $$ParsedFieldDocTableTableOrderingComposer,
          $$ParsedFieldDocTableTableAnnotationComposer,
          $$ParsedFieldDocTableTableCreateCompanionBuilder,
          $$ParsedFieldDocTableTableUpdateCompanionBuilder,
          (ParsedFieldDocRow, $$ParsedFieldDocTableTableReferences),
          ParsedFieldDocRow,
          PrefetchHooks Function({bool cacheId})
        > {
  $$ParsedFieldDocTableTableTableManager(
    _$AppDatabase db,
    $ParsedFieldDocTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParsedFieldDocTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParsedFieldDocTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ParsedFieldDocTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cacheId = const Value.absent(),
                Value<String> pluginName = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> validValues = const Value.absent(),
                Value<String?> examples = const Value.absent(),
                Value<String?> typeInfo = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> parsedAt = const Value.absent(),
              }) => ParsedFieldDocTableCompanion(
                id: id,
                cacheId: cacheId,
                pluginName: pluginName,
                fieldName: fieldName,
                description: description,
                validValues: validValues,
                examples: examples,
                typeInfo: typeInfo,
                confidence: confidence,
                parsedAt: parsedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cacheId,
                required String pluginName,
                required String fieldName,
                Value<String?> description = const Value.absent(),
                Value<String?> validValues = const Value.absent(),
                Value<String?> examples = const Value.absent(),
                Value<String?> typeInfo = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> parsedAt = const Value.absent(),
              }) => ParsedFieldDocTableCompanion.insert(
                id: id,
                cacheId: cacheId,
                pluginName: pluginName,
                fieldName: fieldName,
                description: description,
                validValues: validValues,
                examples: examples,
                typeInfo: typeInfo,
                confidence: confidence,
                parsedAt: parsedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ParsedFieldDocTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cacheId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cacheId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cacheId,
                                referencedTable:
                                    $$ParsedFieldDocTableTableReferences
                                        ._cacheIdTable(db),
                                referencedColumn:
                                    $$ParsedFieldDocTableTableReferences
                                        ._cacheIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParsedFieldDocTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParsedFieldDocTableTable,
      ParsedFieldDocRow,
      $$ParsedFieldDocTableTableFilterComposer,
      $$ParsedFieldDocTableTableOrderingComposer,
      $$ParsedFieldDocTableTableAnnotationComposer,
      $$ParsedFieldDocTableTableCreateCompanionBuilder,
      $$ParsedFieldDocTableTableUpdateCompanionBuilder,
      (ParsedFieldDocRow, $$ParsedFieldDocTableTableReferences),
      ParsedFieldDocRow,
      PrefetchHooks Function({bool cacheId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FieldMetadataTableTableTableManager get fieldMetadataTable =>
      $$FieldMetadataTableTableTableManager(_db, _db.fieldMetadataTable);
  $$MetadataConstraintsTableTableTableManager get metadataConstraintsTable =>
      $$MetadataConstraintsTableTableTableManager(
        _db,
        _db.metadataConstraintsTable,
      );
  $$ConfigPatternsTableTableTableManager get configPatternsTable =>
      $$ConfigPatternsTableTableTableManager(_db, _db.configPatternsTable);
  $$PatternFeedbackTableTableTableManager get patternFeedbackTable =>
      $$PatternFeedbackTableTableTableManager(_db, _db.patternFeedbackTable);
  $$FieldStatisticsTableTableTableManager get fieldStatisticsTable =>
      $$FieldStatisticsTableTableTableManager(_db, _db.fieldStatisticsTable);
  $$DocumentationSourcesTableTableTableManager get documentationSourcesTable =>
      $$DocumentationSourcesTableTableTableManager(
        _db,
        _db.documentationSourcesTable,
      );
  $$DocumentationCacheTableTableTableManager get documentationCacheTable =>
      $$DocumentationCacheTableTableTableManager(
        _db,
        _db.documentationCacheTable,
      );
  $$ParsedFieldDocTableTableTableManager get parsedFieldDocTable =>
      $$ParsedFieldDocTableTableTableManager(_db, _db.parsedFieldDocTable);
}
