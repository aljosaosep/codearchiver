package viewtest.views;


import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.part.*;
import org.eclipse.jface.viewers.*;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.jface.action.*;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.ui.*;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.*;

import org.eclipse.swt.layout.*;


/**
 * This sample class demonstrates how to plug-in a new
 * workbench view. The view shows data obtained from the
 * model. The sample creates a dummy model on the fly,
 * but a real implementation would connect to the model
 * available either in this or another plug-in (e.g. the workspace).
 * The view is connected to the model using a content provider.
 * <p>
 * The view uses a label provider to define how model
 * objects should be presented in the view. Each
 * view can present the same model objects using
 * different labels and icons, if needed. Alternatively,
 * a single label provider can be shared between views
 * in order to ensure that objects of the same type are
 * presented in the same way everywhere.
 * <p>
 */

public class SampleView extends ViewPart {

    Label label;
    Text text;
    Button searchButton;
    Composite searchComposite;
    GridLayout layout;
    Table resultTable;
    
    Composite searchLine;
    
    public SampleView() {
    }
    
    public void createPartControl(Composite parent) {
    	
    	//
    	// Search
    	//
    	
    	// Layout
    	layout = new GridLayout();
    	layout.numColumns = 1;
    	
    	// Container
    	searchComposite = new Composite(parent, SWT.NONE);
    	searchComposite.setLayout ( layout );
   
    	
    	// Label
    	label = new Label(searchComposite, SWT.NONE);
        label.setText("Search code-archive.net: ");
        
        // SearchLine: input + button
    	searchLine = new Composite (searchComposite, SWT.NONE);
    	searchLine.setLayout( new RowLayout() );
        
        // Text input
        text = new Text(searchLine, SWT.BORDER);
        text.setText("Enter search string...");
        
        // Button
        searchButton = new Button(searchLine, SWT.PUSH);
        searchButton.setText("Search");
        
        resultTable = new Table (searchComposite, SWT.MULTI | SWT.BORDER | SWT.FULL_SELECTION);
        resultTable.setLinesVisible (true);
        resultTable.setHeaderVisible (true);
        
    	GridData data = new GridData(SWT.FILL, SWT.FILL, true, true);
    	data.heightHint = 200;
    	
    	resultTable.setLayoutData(data);
    	
    	// Titles
    	String[] titles = {"Title", "Short description", "Grade"};
    	
    	// Add titles to table
    	for (int i=0; i<titles.length; i++) {
    		TableColumn column = new TableColumn (resultTable, SWT.NONE);
    		column.setText (titles [i]);
    	}
        
    	// Test data
    	int count = 128;
    	for (int i=0; i<count; i++) {
    		TableItem item = new TableItem (resultTable, SWT.NONE);
    		item.setText (0, "Hello, world!");
    		item.setText (1, "Super program, ki izpise v konzolo Hello world!");
    		item.setText (2, "100000000");

    	}
    	for (int i=0; i<titles.length; i++) {
    		resultTable.getColumn (i).pack ();
    	}

    }
    public void setFocus() {
       // set focus to my widget.  For a label, this doesn't
       // make much sense, but for more complex sets of widgets
       // you would decide which one gets the focus.
    }
}