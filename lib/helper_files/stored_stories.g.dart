// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_stories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoredStoryAdapter extends TypeAdapter<StoredStory> {
  @override
  final int typeId = 1;

  @override
  StoredStory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoredStory(
      storyid: fields[0] as int,
      index: fields[1] as int,
      coverImage: fields[3] as String,
      backgroundImage: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoredStory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.storyid)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.coverImage)
      ..writeByte(4)
      ..write(obj.backgroundImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredStoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoredStoryListAdapter extends TypeAdapter<StoredStoryList> {
  @override
  final int typeId = 2;

  @override
  StoredStoryList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoredStoryList(
      stories: (fields[0] as List).cast<StoredStory>(),
    );
  }

  @override
  void write(BinaryWriter writer, StoredStoryList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.stories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredStoryListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
