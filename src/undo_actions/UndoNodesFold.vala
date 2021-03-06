/*
* Copyright (c) 2018 (https://github.com/phase1geo/Minder)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Trevor Williams <phase1geo@gmail.com>
*/

using Gtk;

public class UndoNodesFold : UndoItem {

  Array<Node> _nodes;

  /* Default constructor */
  public UndoNodesFold( Array<Node> nodes ) {
    base( _( "node change folds" ) );
    _nodes = nodes;
  }

  /* Toggles the fold indicators */
  private void change( DrawArea da ) {
    for( int i=0; i<_nodes.length; i++ ) {
      var node = _nodes.index( i );
      node.folded = !node.folded;
      node.layout.handle_update_by_fold( node );
    }
    da.queue_draw();
    da.current_changed( da );
    da.changed();
  }

  /* Undoes a node fold operation */
  public override void undo( DrawArea da ) {
    change( da );
  }

  /* Redoes a node fold operation */
  public override void redo( DrawArea da ) {
    change( da );
  }

}
