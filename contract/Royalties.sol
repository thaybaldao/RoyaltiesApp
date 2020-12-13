pragma solidity ^0.4.2;

contract Royalties {
    // Model an Artist
     struct Artist {
         uint id;
         string name;
         uint streamingsTotal;
         uint accountBalance;
         
     }

     // Model a Song
     struct Song {
         uint id;
         string name;
         uint artistId;
         uint streamingsCounter;
         uint streamingsTotal;         
     }
     
     // Read/write artists and songs
     mapping(uint => Artist) public artists;
     mapping(uint => Song) public songs;

     // Store Artist and Song Count
     uint public artistsCount;
     uint public songCount;
    
     constructor() public {
         addArtist("Arctic Monkeys");
         addSong("Fluorescent Adolescent", 1);
         addSong("R U Mine", 1);
         addSong("Snap out of it", 1);
         
         addArtist("Blackpink");
         addSong("How you like that", 2);
         addSong("Kill this love", 2);
         addSong("Lovesick girls", 2);
         
         addArtist("BTS");
         addSong("DNA", 3);
         addSong("Dynamite", 3);
         addSong("Idol", 3);
         
         addArtist("Lady Gaga");
         addSong("Just Dance", 4);
         addSong("Poker Face", 4);
         addSong("Rain on me", 4);
     }
    
     function addArtist(string _name) private {
         artistsCount++;
         artists[artistsCount] = Artist(artistsCount, _name, 0, 0);
     }

     function addSong(string _name, uint _artistId) private {
         require(_artistId > 0 && _artistId <= artistsCount);

         songCount++;
         songs[songCount] = Song(songCount, _name, _artistId, 0, 0);
     }
    
     function listenSong(uint _songId) public {
         // require a valid song
         require(_songId > 0 && _songId <= songCount);
            
         uint artistId = songs[_songId].artistId;

         // update streamingsTotal of artist and song
         artists[artistId].streamingsTotal++;
         songs[_songId].streamingsTotal++;

         // update streamingsCounter of song
         songs[_songId].streamingsCounter++;
         if(songs[_songId].streamingsCounter == 5){
            artists[artistId].accountBalance += 2;
            songs[_songId].streamingsCounter = 0;
         }
     }


     function artistPopularity(uint _artistId) view public returns(uint) {
        require(_artistId > 0 && _artistId <= artistsCount);
        return artists[_artistId].streamingsTotal;
     }

    function artistBalance(uint _artistId) view public returns(uint) {
        require(_artistId > 0 && _artistId <= artistsCount);
        return artists[_artistId].accountBalance;
     }

     function songPopularity(uint _songId) view public returns(uint) {
        require(_songId > 0 && _songId <= songCount);
        return songs[_songId].streamingsTotal;
     }
} 