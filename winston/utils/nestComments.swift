//
//  structureComments.swift
//  winston
//
//  Created by Igor Marcossi on 05/07/23.
//

import Foundation

func nestComments(_ inputComments: [ListingChild<CommentData>], parentID: String, api: RedditAPI) -> [Comment] {
  var rootComments: [Comment] = []
  var commentsMap: [String:Comment] = [:]
  
  inputComments.compactMap { x in
    if let data = x.data, let name = data.name {
      let newComment = Comment(data: data, api: api, kind: x.kind)
      rootComments.append(newComment)
      commentsMap[name] = newComment
      if parentID != name {
        return newComment
      }
    }
    return nil
  }.forEach { x in
    if let data = x.data, let parentName = data.parent_id, let parent = commentsMap[parentName] {
      parent.childrenWinston.data.append(x)
    }
  }
  
  return rootComments
}