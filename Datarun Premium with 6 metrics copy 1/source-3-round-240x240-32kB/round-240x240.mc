using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

//! inherit from the view that contains the commonlogic
class DeviceView extends PowerView {
	var myTime;
	var strTime;

	//! it's good practice to always have an initialize, make sure to call your parent class here!
    function initialize() {
        PowerView.initialize();
    }

	function onUpdate(dc) {
		//! call the parent function in order to execute the logic of the parent
		PowerView.onUpdate(dc);

		//! Draw separator lines
        dc.setColor(mColourLine, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);

        //! Horizontal thirds
        dc.drawLine(40,  28,  200, 28);
        dc.drawLine(0,   92,  237, 92);
        dc.drawLine(0,   156, 237, 156);

        //! Top vertical divider
        dc.drawLine(119, 29,  119, 92);

        //! Centre vertical divider
        dc.drawLine(164, 92,  164, 156);

        //! Bottom vertical divider
        dc.drawLine(119, 156, 119, 219);
        
        //! Bottom horizontal divider
        dc.drawLine(53, 219, 187, 219);	

        dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		//! Show clock with current time in top
		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d");
        dc.drawText(120, -4, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);

		//! Display metrics
		for (var i = 1; i < 7; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"069,068,073,013,074,073,037");
	       	} else if ( i == 2 ) {	//!upper row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"170,068,180,121,074,167,037");
	       	} else if ( i == 3 ) {  //!middle row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"095,123,097,018,139,008,140");
	       	} else if ( i == 4 ) {  //!middle row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"202,132,000,000,000,201,101");
	       	} else if ( i == 5 ) {	//!lower row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"070,176,073,014,172,080,208");
	       	} else if ( i == 6 ) {	//!lower row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"170,176,180,121,182,157,208");
	       	}      	
		}
		
		if (jTimertime == 0) {
	    	if (uShowRedClock == true) {
		    	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
				dc.drawText(120, 160, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		    }
		}
		
		//! Bottom battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(92, 222, 54, 15);
		dc.fillRectangle(146, 225, 3, 8);
		
		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Startstatuspwrbr = 94 + pwr*0.5  ;
		var Endstatuspwrbr = 50 - pwr*0.5 ;
		dc.fillRectangle(Startstatuspwrbr, 224, Endstatuspwrbr, 11);	

	}

}