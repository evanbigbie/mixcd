import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:mixcd/controller/myfirebase.dart';

import '../view/mixpage.dart';
import '../view/cdpage.dart';
import '../model/cd.dart';
import '../view/sharedpage.dart';
import '../view/servicepage.dart';

class MixPageController {
  MixPageState state;

  MixPageController(this.state);

  void signOut() {
    MyFirebase.signOut();
    Navigator.pop(state.context); // to close the drawer at homepage
    Navigator.pop(state.context); // to return to the front page
  }

  void addButton() async {
    CD cd = await Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => CDPage(state.user, null),
        ));
    if (cd != null) {
      // new cd stored in Firebase
      state.cdlist.add(cd);
    } else {
      // error occurred in storing in Firebase
    }
  }

  void playButton() async {
    const url = 'https://msayyid.bandcamp.com/track/silver-light';
    //var url = state.songlist;
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
      print("something is happening");
    } else {
      throw 'Could not launch $url';
    }
  }

  void onTap(int index) async {
    if (state.deleteIndices == null) {
      // navigate to CDPage
      CD cd = await Navigator.push(
          state.context,
          MaterialPageRoute(
            builder: (context) => CDPage(state.user, state.cdlist[index]), // added null here * 12/4 *      //     compiler does not like this
          ));

      if (cd != null) {
        // updated cd is stored in Firebase
        state.cdlist[index] = cd;
      }
    } else {
      // add to delete list
      if (state.deleteIndices.contains(index)) {
        // tapped again -> deselect
        state.deleteIndices.remove(index);
        if (state.deleteIndices.length == 0) {
          // all deselected. delete mode quits
          state.deleteIndices = null;
        }
      } else {
        state.deleteIndices.add(index);
      }
      state.stateChanged(() {});
    }
  }

  void longPress(int index) {
    if (state.deleteIndices == null) {
      // begin delete mode
      state.stateChanged(() {
        state.deleteIndices = <int>[index];
      });
    }
  }

  void deleteButton() async {
    // sort descending order of deleteIndices
    state.deleteIndices.sort((n1, n2) {
      if (n1 < n2)
        return 1;
      else if (n1 == n2)
        return 0;
      else
        return -1;
    });

    // delete indices: [5, 2, 1, 6]
    for (var index in state.deleteIndices) {
      try {
        await MyFirebase.deleteCD(state.cdlist[index]);
        state.cdlist.removeAt(index);
      } catch (e) {
        print('CD DELETE ERROR: ' + e.toString());
      }
    }
    state.stateChanged(() {
      state.deleteIndices = null;
    });
  }

  void sharedWithMeMenu() async {
    List<CD> cds = await MyFirebase.getCDsSharedWithMe(state.user.email);
    print('# of cds: ' + cds.length.toString());
    for (var cd in cds) {
      print(cd.name);
    }
    // navigate to a new page for SharedCDs
    await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => SharedCDsPage(state.user, cds),
    ));
    Navigator.pop(state.context); // close the drawer
  }

  void serviceMenu() async {
    await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ServicePage(state.user),
    ));
    Navigator.pop(state.context);
  }
}
