import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pahe_app/movie/models/movie_detail_model.dart';
import 'package:pahe_app/movie/models/movie_model.dart';
import 'package:pahe_app/movie/models/movie_video_model.dart';
import 'package:pahe_app/movie/repostories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Terjadi kesalahan saat menemukan film');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Terjadi kesalahan lain saat menemukan film');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Terjadi kesalahan saat mendapatkan peringkat teratas');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left(
          'Terjadi kesalahan lain saat mendapatkan peringkat teratas');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left(
          'Terjadi Terjadi kesalahan saat mendapatkan sedang tayang');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left(
          'Terjadi Terjadi kesalahan lain saat mendapatkan sedang tayang');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Terjadi kesalahan mendapatkan detail film');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Terjadi kesalahan lain saat mendapatkan detail film');
    }
  }

  @override
  Future<Either<String, MovieVideosModel>> getVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id/videos',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieVideosModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Terjadi kesalahan saat mendapatkan cuplikan film');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left(
          'Terjadi kesalahan lain saat mendapatkan cuplikan film');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> search({
    required String query,
  }) async {
    try {
      final result = await _dio.get(
        '/search/movie',
        queryParameters: {"query": query},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Terjadi kesalahan pencarian film');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Terjadi kesalahan lain saat pencarian film');
    }
  }
}
