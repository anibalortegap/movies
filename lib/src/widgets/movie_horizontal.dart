import 'package:flutter/material.dart';
import 'package:movies/src/models/movies_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  MovieHorizontal({@required this.movies, @required this.nextPage});
  @override
  build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        // children: _cards(context)
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, index) {
          return _card(context, movies[index]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    movie.uuid = '${movie.id}-card';
    final movies = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uuid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: movies,
      onTap: () {
        Navigator.pushNamed(context, 'Detail', arguments: movie);
      },
    );
  }

  List<Widget> _cards(context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
