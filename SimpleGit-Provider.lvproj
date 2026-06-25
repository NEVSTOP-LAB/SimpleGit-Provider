<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="17008000">
	<Property Name="NI.LV.All.SaveVersion" Type="Str">17.0</Property>
	<Property Name="NI.LV.All.SourceOnly" Type="Bool">true</Property>
	<Property Name="NI.Project.Description" Type="Str"></Property>
	<Property Name="SMProvider.SMVersion" Type="Int">201310</Property>
	<Item Name="My Computer" Type="{CEFE1B10-1732-4678-A70A-299293455410}">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="_scripts" Type="Folder" URL="../SimpleGit/Git/_scripts">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="support" Type="Folder">
			<Item Name="Close Caller FP if In LabVIEW folder.vi" Type="VI" URL="../SimpleGit/Git/_Support/Close Caller FP if In LabVIEW folder.vi"/>
			<Item Name="DailyPatchBranchName.vi" Type="VI" URL="../SimpleGit/Git/_Support/DailyPatchBranchName.vi"/>
			<Item Name="Git Check whether Branch exists.vi" Type="VI" URL="../SimpleGit/Git/_Support/Git Check whether Branch exists.vi"/>
			<Item Name="GIT-Current Local Branches.vi" Type="VI" URL="../SimpleGit/Git/_Support/GIT-Current Local Branches.vi"/>
			<Item Name="lvgit commit.vi" Type="VI" URL="../SimpleGit/Git/_Support/lvgit commit.vi"/>
			<Item Name="lvgit pull.vi" Type="VI" URL="../SimpleGit/Git/_Support/lvgit pull.vi"/>
			<Item Name="lvgit push.vi" Type="VI" URL="../SimpleGit/Git/_Support/lvgit push.vi"/>
			<Item Name="lvgit status.vi" Type="VI" URL="../SimpleGit/Git/_Support/lvgit status.vi"/>
			<Item Name="menu-operation.lvlib" Type="Library" URL="../SimpleGit/Git/_Support/menu-Operations/menu-operation.lvlib"/>
			<Item Name="path to cmd argument.vi" Type="VI" URL="../SimpleGit/Git/_Support/path to cmd argument.vi"/>
			<Item Name="SimpleGit Setting Dialog.vi" Type="VI" URL="../SimpleGit/Git/_Support/SimpleGit Setting Dialog.vi"/>
			<Item Name="SimpleGit-Commit.vi" Type="VI" URL="../SimpleGit/Git/Command/SimpleGit-Commit.vi"/>
			<Item Name="SimpleGit-LeaveDailyBranch.vi" Type="VI" URL="../SimpleGit/Git/Command/SimpleGit-LeaveDailyBranch.vi"/>
			<Item Name="SimpleGit-Pull.vi" Type="VI" URL="../SimpleGit/Git/Command/SimpleGit-Pull.vi"/>
			<Item Name="SimpleGit-Push.vi" Type="VI" URL="../SimpleGit/Git/Command/SimpleGit-Push.vi"/>
			<Item Name="SimpleGit-Settings.vi" Type="VI" URL="../SimpleGit/Git/Command/SimpleGit-Settings.vi"/>
			<Item Name="SimpleGit-Status.vi" Type="VI" URL="../SimpleGit/Git/Command/SimpleGit-Status.vi"/>
			<Item Name="SimpleGit-SwitchToDailyBranch.vi" Type="VI" URL="../SimpleGit/Git/Command/SimpleGit-SwitchToDailyBranch.vi"/>
			<Item Name="simplegit.DailyBranchPrefix.vi" Type="VI" URL="../SimpleGit/Git/_Support/config/simplegit.DailyBranchPrefix.vi"/>
			<Item Name="simplegit.TortoiseGitProc.vi" Type="VI" URL="../SimpleGit/Git/_Support/config/simplegit.TortoiseGitProc.vi"/>
			<Item Name="SimpleGit_Item_OnCommand.vi" Type="VI" URL="../SimpleGit/Git/SimpleGit_Item_OnCommand.vi"/>
			<Item Name="SimpleGit_Item_OnPopupMenu.vi" Type="VI" URL="../SimpleGit/Git/SimpleGit_Item_OnPopupMenu.vi"/>
			<Item Name="SimpleGit_Item_OnUpdateCommand.vi" Type="VI" URL="../SimpleGit/Git/SimpleGit_Item_OnUpdateCommand.vi"/>
			<Item Name="SimpleGit_Menu_Hierachy.vi" Type="VI" URL="../SimpleGit/Git/SimpleGit_Menu_Hierachy.vi"/>
			<Item Name="SimpleGit_OnCommand(SingleObject).vi" Type="VI" URL="../SimpleGit/Git/SimpleGit_OnCommand(SingleObject).vi"/>
			<Item Name="Tortoisegit commit.vi" Type="VI" URL="../SimpleGit/Git/_Support/tortoisegit/Tortoisegit commit.vi"/>
			<Item Name="Tortoisegit Exists.vi" Type="VI" URL="../SimpleGit/Git/_Support/tortoisegit/Tortoisegit Exists.vi"/>
			<Item Name="Tortoisegit pull.vi" Type="VI" URL="../SimpleGit/Git/_Support/tortoisegit/Tortoisegit pull.vi"/>
			<Item Name="Tortoisegit push.vi" Type="VI" URL="../SimpleGit/Git/_Support/tortoisegit/Tortoisegit push.vi"/>
			<Item Name="Tortoisegit status.vi" Type="VI" URL="../SimpleGit/Git/_Support/tortoisegit/Tortoisegit status.vi"/>
			<Item Name="Tortoisegitproc default path.vi" Type="VI" URL="../SimpleGit/Git/_Support/tortoisegit/Tortoisegitproc default path.vi"/>
		</Item>
		<Item Name="SimpleGit_Global_Interface.vi" Type="VI" URL="../SimpleGit/SimpleGit_Global_Interface.vi"/>
		<Item Name="SimpleGit_Item_Interface.vi" Type="VI" URL="../SimpleGit/SimpleGit_Item_Interface.vi"/>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
