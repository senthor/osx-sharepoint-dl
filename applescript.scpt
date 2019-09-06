on run {input, parameters}
	set urls to {}
	tell application "Safari"
		tell its front document
			set base_url to do JavaScript "window.location.protocol + '//' + window.location.host"
			if base_url does not contain "sharepoint." then         -- change base URL accordingly or leave check out
				display alert "No SharePoint opened!"                 -- 
				error number -128                                     --
			end if                                                  --
			set project to ("/" & (do JavaScript "window.location.pathname.split('/')[1]") & "/" & (do JavaScript "window.location.pathname.split('/')[2]") & "/")
			set SP_List to do JavaScript "WPQ2ListData"
		end tell
		repeat with SP_item in Row of SP_List
			if File_x0020_Type of SP_item is not "" then
				set end of urls to (FileRef of SP_item)
			end if
		end repeat
		
    -- 3 ways to download files were tested, including obsolete ones for testing and developing purposes
    
		------------------------------------------------------------ Download with cURL (obsolete) ------------------------------------------------------------
		(*set d_auth to text returned of (display dialog "Number of entries found: " & (count of (Row of SP_List)) & ", number of downloadable files:" & (count of urls) & "  

Please enter username:password" default answer "username:password" with title "SharePoint Download")
		set d_path to the POSIX path of (choose folder with prompt "Where to download to?" default location (path to downloads folder))
		repeat with item_url in urls
			do shell script "cd " & d_path & " && curl --ntlm -u " & d_auth & " -O '" & base_url & item_url & "'"
		end repeat
		display alert "Download finished."*)
		
		------------------------------------------------------------ Download with Safari ------------------------------------------------------------
		(*
		tell window 1
			repeat with item_url in urls
				set current tab to (make new tab with properties {URL:base_url & project & "_layouts/15/download.aspx?SourceUrl=" & item_url})
			end repeat
		end tell
		delay (count of urls) * 0.15 + 2
		close (every tab of window 1 whose name is "Untitled")
		display alert ((((count of urls) as string) & " of " & (count of (Row of SP_List)) as string) & " files have been downloaded.")*)
		
		------------------------------------------------------------ Download with Automator ------------------------------------------------------------
		set full_urls to {}
		repeat with item_url in urls
			set end of full_urls to base_url & item_url
		end repeat
		display dialog (((count of (Row of SP_List)) as string) & " entries found, " & (count of urls) as string) & " files to download…"
		return full_urls
	end tell
end run
