//
//  MPCManager.swift
//  bonfire
//
//  Created by Allan Martinez on 5/26/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//
//

import MultipeerConnectivity

// protocol for implementing delegation pattern, declare all delegate methods
protocol MPCManagerDelegate {
    func foundPeer()
    
    func lostPeer()
    
    func invitationWasReceived(fromPeer: String)
    
    func connectedWithPeer(peerID: MCPeerID)
}

// Inherit from delegate protocol classes
class MPCManager: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    
    // delegate object
    var delegate:MPCManagerDelegate?
    
    // MPC classes/objects needed
    var session: MCSession!
    var peer: MCPeerID!
    var browser: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!
    
    // More Variables
    var foundPeers = [MCPeerID]() // stores array of found peers
    var invitationHandler: ((Bool, MCSession) ->Void)! // Completion handler declaration
    
    
    override init(){
        
        super.init()
        
        //Initialize variables
        peer = MCPeerID(displayName: UIDevice.currentDevice().name) // Initialize display name as device name
        
        //session = MCSession(peer: peer, securityIdentity: [myIdentity], encryptionPreference: MCEncryptionPreference.Required)
        
        session = MCSession(peer: peer) // Initialize session object
        session.delegate = self // Make our class the delegate of session object
        
        browser = MCNearbyServiceBrowser(peer: peer, serviceType: kAppName) // serviceType uniquely identifies the app
        browser.delegate = self
        
        //TODO: When need to add new information to advertiser. Stop it, and reinitialize
        advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: nil, serviceType: kAppName) // discoveryInfo is a dictionary of extra information to pass to peers upon discovery
        advertiser.delegate = self
        
    }
    
    //Delegate methods
    
    // Called when nearby peer is found, checks is peer already exists in database then calls foundPeer delegate method
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        var peerAlreadyInBrowser = false
        
        //TODO: All discover information for a specific peer will be here. Need to pass it to the foundPeer delegate
        //TODO LATER: Implement faster search function to find peers and remove
        
        // check foundPeers array if found peer exists already
        for (index, aPeer) in foundPeers.enumerate()
        {
            if aPeer == peerID{
                foundPeers.insert(peerID, atIndex: index)
                peerAlreadyInBrowser = true
                break
            }
        }
        
        if !peerAlreadyInBrowser{
            foundPeers.append(peerID)
        }
        
        delegate?.foundPeer()
    }
    
    // Called when a nearby peer is no longer discoverable
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        for (index, aPeer) in foundPeers.enumerate()
        {
            if aPeer == peerID{
                foundPeers.removeAtIndex(index)
                let messageDictionary: [String: String] = [kCommunicationsMessageTerm: kCommunicationsLostConnectionTerm]
                let dataToSend = NSKeyedArchiver.archivedDataWithRootObject(messageDictionary)
                let dictionary: [String: AnyObject] = [kCommunicationsDataTerm : dataToSend, kCommunicationsFromPeerTerm: aPeer]
                NSNotificationCenter.defaultCenter().postNotificationName("receivedMPCDisconnectionNotification", object: dictionary)
                break
            }
        }
        
        delegate?.lostPeer()
    }
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        print(error.localizedDescription)
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: ((Bool, MCSession) -> Void)) {
        
        self.invitationHandler = invitationHandler
        
        //Information user is interested in should be in "withContext" and passed to invitationWasReceived
        delegate?.invitationWasReceived(peerID.displayName)
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        print(error.localizedDescription)
    }
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state{
        case MCSessionState.Connected:
            print("Connected to session: \(session)")
            delegate?.connectedWithPeer(peerID)
            
        case MCSessionState.Connecting:
            print("Connecting to session \(session)")
            
        case MCSessionState.NotConnected:
            print("Not connected to session \(session)")
            let messageDictionary: [String: String] = [kCommunicationsMessageTerm: kCommunicationsLostConnectionTerm]
            let dataToSend = NSKeyedArchiver.archivedDataWithRootObject(messageDictionary)
            let dictionary: [String: AnyObject] = [kCommunicationsDataTerm : dataToSend, kCommunicationsFromPeerTerm: peerID]
            NSNotificationCenter.defaultCenter().postNotificationName("receivedMPCChatDataNotification", object: dictionary)
        }
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
        //REMEMBER: Do not remove the following lines, they are needed to receive Messages from peer
        let dictionary: [String: AnyObject] = [
            kCommunicationsDataTerm: data,
            kCommunicationsFromPeerTerm: peerID]
        NSNotificationCenter.defaultCenter().postNotificationName("receivedMPCChatDataNotification", object: dictionary)
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: ((Bool) -> Void)) {
        
        //This is needed if certificates are not implement. Ommitting will not allow MPC to connect
        certificateHandler(true)
    }
    
    
    func sendData(dictionaryWithData dictionary: Dictionary<String,String>, toPeer targetPeer: MCPeerID) -> Bool {
        
        //This is the data that gets sent to peer
        let dataToSend = NSKeyedArchiver.archivedDataWithRootObject(dictionary)
        let peersArray = [targetPeer]
        
        do {
            try session.sendData(dataToSend, toPeers: peersArray, withMode: MCSessionSendDataMode.Reliable)
        }catch let error as NSError {
            
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    
}