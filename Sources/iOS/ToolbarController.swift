/*
 * Copyright (C) 2015 - 2017, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit

public extension UIViewController {
    /**
     A convenience property that provides access to the ToolbarController.
     This is the recommended method of accessing the ToolbarController
     through child UIViewControllers.
     */
    var toolbarController: ToolbarController? {
        return traverseViewControllerHierarchyForClassType()
    }
}

@objc(ToolbarController)
open class ToolbarController: StatusBarController {
    /// Reference to the Toolbar.
    @IBInspectable
    open let toolbar = Toolbar()
    
    open override func layoutSubviews() {
		super.layoutSubviews()
        
        let y = Application.shouldStatusBarBeHidden || statusBar.isHidden ? 0 : statusBar.height
        
        toolbar.y = y
        toolbar.width = view.width
        
        switch displayStyle {
        case .partial:
            let h = y + toolbar.height
            container.y = h
            container.height = view.height - h
        case .full:
            container.frame = view.bounds
        }
        
        rootViewController.view.frame = container.bounds
	}
	
	/**
     Prepares the view instance when intialized. When subclassing,
     it is recommended to override the prepare method
     to initialize property values and other setup operations.
     The super.prepare method should always be called immediately
     when subclassing.
     */
	open override func prepare() {
		super.prepare()
        displayStyle = .partial
        
        prepareStatusBar()
        prepareToolbar()
	}
}

extension ToolbarController {
    /// Prepares the statusBar.
    fileprivate func prepareStatusBar() {
        shouldHideStatusBarOnRotation = false
    }

    /// Prepares the toolbar.
    fileprivate func prepareToolbar() {
        toolbar.depthPreset = .depth1
        view.addSubview(toolbar)
    }
}
