import 'package:intl/intl.dart';

class Episode {
  dynamic id;
  dynamic url;
  dynamic name;
  dynamic season;
  dynamic number;
  dynamic type;
  dynamic airdate;
  dynamic airtime;
  dynamic airstamp;
  dynamic runtime;
  dynamic image;
  dynamic summary;
  Show show;
  EpisodeLinks lLinks;

  Episode(
      {this.id,
        this.url,
        this.name,
        this.season,
        this.number,
        this.type,
        this.airdate,
        this.airtime,
        this.airstamp,
        this.runtime,
        this.image,
        this.summary,
        this.show,
        this.lLinks});

  Episode.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    season = json['season'];
    number = json['number'];
    type = json['type'];
    airdate = json['airdate'];
    airtime = json['airtime'];
    airstamp = json['airstamp'];
    runtime = json['runtime'];
    image = json['image'];
    summary = json['summary'];
    show = json['show'] != null ? new Show.fromJson(json['show']) : null;
    lLinks = json['_links'] != null ? new EpisodeLinks.fromJson(json['_links']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['season'] = this.season;
    data['number'] = this.number;
    data['type'] = this.type;
    data['airdate'] = this.airdate;
    data['airtime'] = this.airtime;
    data['airstamp'] = this.airstamp;
    data['runtime'] = this.runtime;
    data['image'] = this.image;
    data['summary'] = this.summary;
    if (this.show != null) {
      data['show'] = this.show.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }

  String get airtimestr{
    // Format Symbol Documentation
    // https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
    var dateTime = DateFormat('H:m').parse(airtime);
    final DateFormat formatter = DateFormat('h:m a');
    final String formattedTime = formatter.format(dateTime);
    return formattedTime;
  }

  String get daysCommaSeparated{
    String daysString = '';
    show.schedule.days.forEach((element) {
      daysString  = daysString+element;
      if ( element != show.schedule.days.last){
        daysString = daysString+', ';
      }
    });
    return daysString;
  }

}

class Show {
  dynamic id;
  dynamic url;
  dynamic name;
  dynamic type;
  dynamic language;
  List<dynamic> genres;
  dynamic status;
  dynamic runtime;
  dynamic premiered;
  dynamic officialSite;
  Schedule schedule;
  Rating rating;
  dynamic weight;
  Network network;
  dynamic webChannel;
  Externals externals;
  Photo image;
  dynamic summary;
  dynamic updated;
  ShowLinks lLinks;

  Show(
      {this.id,
        this.url,
        this.name,
        this.type,
        this.language,
        this.genres,
        this.status,
        this.runtime,
        this.premiered,
        this.officialSite,
        this.schedule,
        this.rating,
        this.weight,
        this.network,
        this.webChannel,
        this.externals,
        this.image,
        this.summary,
        this.updated,
        this.lLinks});

  Show.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
    language = json['language'];
    genres = json['genres'].cast<dynamic>();
    status = json['status'];
    runtime = json['runtime'];
    premiered = json['premiered'];
    officialSite = json['officialSite'];
    schedule = json['schedule'] != null
        ? new Schedule.fromJson(json['schedule'])
        : null;
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    weight = json['weight'];
    network =
    json['network'] != null ? new Network.fromJson(json['network']) : null;
    webChannel = json['webChannel'];
    externals = json['externals'] != null
        ? new Externals.fromJson(json['externals'])
        : null;
    image = json['image'] != null ? new Photo.fromJson(json['image']) : null;
    summary = json['summary'];
    updated = json['updated'];
    lLinks = json['_links'] != null ? new ShowLinks.fromJson(json['_links']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['language'] = this.language;
    data['genres'] = this.genres;
    data['status'] = this.status;
    data['runtime'] = this.runtime;
    data['premiered'] = this.premiered;
    data['officialSite'] = this.officialSite;
    if (this.schedule != null) {
      data['schedule'] = this.schedule.toJson();
    }
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['weight'] = this.weight;
    if (this.network != null) {
      data['network'] = this.network.toJson();
    }
    data['webChannel'] = this.webChannel;
    if (this.externals != null) {
      data['externals'] = this.externals.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['summary'] = this.summary;
    data['updated'] = this.updated;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Schedule {
  dynamic time;
  List<dynamic> days;

  Schedule({this.time, this.days});

  Schedule.fromJson(Map<dynamic, dynamic> json) {
    time = json['time'];
    days = json['days'].cast<dynamic>();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['time'] = this.time;
    data['days'] = this.days;
    return data;
  }
}

class Rating {
  dynamic average;

  Rating({this.average});

  Rating.fromJson(Map<dynamic, dynamic> json) {
    average = json['average'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['average'] = this.average;
    return data;
  }
}

class Network {
  dynamic id;
  dynamic name;
  Country country;

  Network({this.id, this.name, this.country});

  Network.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Country {
  dynamic name;
  dynamic code;
  dynamic timezone;

  Country({this.name, this.code, this.timezone});

  Country.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    code = json['code'];
    timezone = json['timezone'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['timezone'] = this.timezone;
    return data;
  }
}

class Externals {
  dynamic tvrage;
  dynamic thetvdb;
  dynamic imdb;

  Externals({this.tvrage, this.thetvdb, this.imdb});

  Externals.fromJson(Map<dynamic, dynamic> json) {
    tvrage = json['tvrage'];
    thetvdb = json['thetvdb'];
    imdb = json['imdb'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['tvrage'] = this.tvrage;
    data['thetvdb'] = this.thetvdb;
    data['imdb'] = this.imdb;
    return data;
  }
}

class Photo {
  dynamic medium;
  dynamic original;

  Photo({this.medium, this.original});

  Photo.fromJson(Map<dynamic, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['medium'] = this.medium;
    data['original'] = this.original;
    return data;
  }
}

class ShowLinks {
  Self self;
  Self previousepisode;
  Self nextepisode;

  ShowLinks({this.self, this.previousepisode, this.nextepisode});

  ShowLinks.fromJson(Map<dynamic, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    previousepisode = json['previousepisode'] != null
        ? new Self.fromJson(json['previousepisode'])
        : null;
    nextepisode = json['nextepisode'] != null
        ? new Self.fromJson(json['nextepisode'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.previousepisode != null) {
      data['previousepisode'] = this.previousepisode.toJson();
    }
    if (this.nextepisode != null) {
      data['nextepisode'] = this.nextepisode.toJson();
    }
    return data;
  }
}

class Self {
  dynamic href;

  Self({this.href});

  Self.fromJson(Map<dynamic, dynamic> json) {
    href = json['href'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class EpisodeLinks {
  Self self;

  EpisodeLinks({this.self});

  EpisodeLinks.fromJson(Map<dynamic, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    return data;
  }
}