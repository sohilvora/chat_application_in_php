<?php

namespace MyApp;

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

require dirname(__DIR__) . '/database/ChatUser.php';
require dirname(__DIR__) . '/database/ChatRooms.php';
require dirname(__DIR__) . '/database/PrivateChat.php';

class Chat implements MessageComponentInterface
{
    protected $clients;

    public function __construct()
    {
        $this->clients = new \SplObjectStorage;
    }

    public function onOpen(ConnectionInterface $conn)
    {
        // Store the new connection to send messages to later
        $this->clients->attach($conn);

        $querystring = $conn->httpRequest->getUri()->getQuery();

        parse_str($querystring, $queryarray);
        $user_obj = new \ChatUser;
        $user_obj->setUserToken($queryarray['token']);
        $user_obj->setUserConnectionId($conn->resourceId);
        $user_obj->update_user_connection_id();

        echo "New connection! ({$conn->resourceId})\n";
    }

    public function onMessage(ConnectionInterface $from, $msg)
    {
        $numRecv = count($this->clients) - 1;
        echo sprintf(
            'Connection %d sending message "%s" to %d other connection%s' . "\n",
            $from->resourceId,
            $msg,
            $numRecv,
            $numRecv == 1 ? '' : 's'
        );

        $data = json_decode($msg, true);

        if ($data['command'] == 'private') {
            $private_chat_obj = new \PrivateChat;
            $private_chat_obj->setToUserId($data['reciever_userid']);
            $private_chat_obj->setFromUserId($data['userId']);
            $private_chat_obj->setChatMessage($data['msg']);
            $timestamp = date("d-m-Y h:i:s");
            $private_chat_obj->setTimestamp($timestamp);
            $private_chat_obj->setStatus('Yes');
            $chat_message_id = $private_chat_obj->save_chat();
            $user_obj = new \ChatUser;
            $user_obj->setUserId($data['userId']);
            $sender_user_data = $user_obj->get_user_data_by_id();
            $user_obj->setUserId($data['reciever_userid']);
            $reciever_user_data = $user_obj->get_user_data_by_id();
            $sender_user_name = $sender_user_data['user_name'];
            $data['datetime'] = $timestamp;
            $reciever_user_connection_id = $reciever_user_data['user_connection_id'];
            foreach ($this->clients as $client) {
                if ($from == $client) {
                    $data['from'] = "Me";
                } else {
                    $data['from'] = $sender_user_name;
                }
                if ($client->resourceId == $reciever_user_connection_id || $from == $client) {
                    $client->send(json_encode($data));
                } else {
                    $private_chat_obj->setStatus('No');
                    $private_chat_obj->setChatMessageId($chat_message_id);
                    $private_chat_obj->update_chat_status();
                }
            }
        } else {
            $chat_room_obj = new \ChatRooms;
            $chat_room_obj->setUserId($data['user_id']);
            $chat_room_obj->setMessage($data['msg']);
            $chat_room_obj->setCreatedOn(date("d-m-Y h:i:s"));
            $chat_room_obj->save_chat();

            $user_obj = new \ChatUser;
            $user_obj->setUserId($data['user_id']);
            $user_data = $user_obj->get_user_data_by_id();
            $user_name = $user_data['user_name'];
            $data['dt'] = date("d-m-Y h:i:s");

            foreach ($this->clients as $client) {
                // if ($from !== $client) {
                //     // The sender is not the receiver, send to each client connected
                //     $client->send($msg);
                // }

                if ($from == $client) {
                    $data['from'] = 'Me';
                } else {
                    $data['from'] = $user_name;
                }

                $client->send(json_encode($data));
            }
        }
    }

    public function onClose(ConnectionInterface $conn)
    {
        $querystring = $conn->httpRequest->getUri()->getQuery();
        parse_str($querystring, $queryarray);

        $user_obj = new \ChatUser;
        $user_obj->setUserToken($queryarray['token']);
        $user_data = $user_obj->get_user_id_from_token();
        $user_id = $user_data['user_id'];
        $data['status_type'] = 'Offline';
        $data['user_id_status'] = $user_id;
        foreach ($this->clients as $client) {
            $client->send(json_encode($data));
        }
        // The connection is closed, remove it, as we can no longer send it messages
        $this->clients->detach($conn);

        echo "Connection {$conn->resourceId} has disconnected\n";
    }

    public function onError(ConnectionInterface $conn, \Exception $e)
    {
        echo "An error has occurred: {$e->getMessage()}\n";

        $conn->close();
    }
}
